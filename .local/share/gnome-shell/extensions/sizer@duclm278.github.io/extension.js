/**
 * By orzun
 * Modified by duclm278
 * License: GPLv3
 *
 * Install:
 * 1. Run: make install
 * 2. X11: Restart gnome-shell (Alt+F2, r, Enter)
 * 3. Wayland: Logout and login
 * 4. Run: gnome-extensions enable sizer@duclm278.github.io
 *
 * Usage:
 * gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Sizer --method org.gnome.Shell.Extensions.Sizer.MoveResize 0 0 1600 900
 */

const { Gio, GLib, Clutter, Meta, Shell, St } = imports.gi;

const Main = imports.ui.main;

const MESSAGE_FADE_TIME = 2000;

const MR_DBUS_IFACE = `
<node>
    <interface name="org.gnome.Shell.Extensions.Sizer">
        <method name="Get">
        </method>
        <method name="Move">
            <arg type="u" direction="in" name="x"/>
            <arg type="u" direction="in" name="y"/>
        </method>
        <method name="MoveResize">
            <arg type="u" direction="in" name="x"/>
            <arg type="u" direction="in" name="y"/>
            <arg type="u" direction="in" name="width"/>
            <arg type="u" direction="in" name="height"/>
        </method>
    </interface>
</node>`;

class Extension {
  enable() {
    this._dbus = Gio.DBusExportedObject.wrapJSObject(MR_DBUS_IFACE, this);
    this._dbus.export(Gio.DBus.session, "/org/gnome/Shell/Extensions/Sizer");
  }

  disable() {
    this._dbus.flush();
    this._dbus.unexport();
    delete this._dbus;
  }

  _flashMessage(message) {
    if (!this._text) {
      this._text = new St.Label({ style_class: "screenshot-sizer-message" });
      Main.uiGroup.add_actor(this._text);
    }

    this._text.remove_all_transitions();
    this._text.text = message;

    this._text.opacity = 255;

    const monitor = Main.layoutManager.primaryMonitor;
    this._text.set_position(
      monitor.x + Math.floor(monitor.width / 2 - this._text.width / 2),
      monitor.y + Math.floor(monitor.height / 2 - this._text.height / 2)
    );

    this._text.ease({
      opacity: 0,
      duration: MESSAGE_FADE_TIME,
      mode: Clutter.AnimationMode.EASE_OUT_QUAD,
      onComplete: () => this._hideMessage(),
    });
  }

  _hideMessage() {
    this._text.destroy();
    delete this._text;
  }

  _notifySizeChange(window) {
    const { scaleFactor } = St.ThemeContext.get_for_stage(global.stage);
    let newOuterRect = window.get_frame_rect();
    let newInnerRect = window.get_buffer_rect();
    let message = "";
    message += "Pos: (%d,%d)\n".format(
      newOuterRect.x / scaleFactor,
      newOuterRect.y / scaleFactor
    );
    message += "Inner: %dx%d\n".format(
      newInnerRect.width / scaleFactor,
      newInnerRect.height / scaleFactor
    );
    message += "Outer: %dx%d".format(
      newOuterRect.width / scaleFactor,
      newOuterRect.height / scaleFactor
    );

    this._flashMessage(message);
  }

  Get() {
    const window = global.display.get_focus_window();
    if (!window) return;

    this._notifySizeChange(window);
  }

  Move(x, y) {
    const window = global.display.get_focus_window();
    if (!window) return;

    if (window.get_maximized() !== 0) {
      window.unmaximize(Meta.MaximizeFlags.BOTH);
    }

    const posId = window.connect("position-changed", () => {
      window.disconnect(posId);
      this._notifySizeChange(window);
    });
    window.move_frame(1, x, y);
  }

  MoveResize(x, y, width, height) {
    const window = global.display.get_focus_window();
    if (!window) return;

    if (window.get_maximized() !== 0) {
      window.unmaximize(Meta.MaximizeFlags.BOTH);
    }

    const posId = window.connect("position-changed", () => {
      window.disconnect(posId);
      this._notifySizeChange(window);
    });
    const sizeId = window.connect("size-changed", () => {
      window.disconnect(sizeId);
      this._notifySizeChange(window);
    });
    window.move_frame(1, x, y);
    window.move_resize_frame(1, x, y, width, height);
  }
}

function init() {
  return new Extension();
}
