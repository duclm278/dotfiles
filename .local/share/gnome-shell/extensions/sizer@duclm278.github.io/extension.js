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
 * gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Sizer --method org.gnome.Shell.Extensions.Sizer.Call 0 0 1600 900
 */

const { Gio } = imports.gi;

const MR_DBUS_IFACE = `
<node>
    <interface name="org.gnome.Shell.Extensions.Sizer">
        <method name="Call">
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

  Call(x, y, width, height) {
    const win = global
      .get_window_actors()
      .map((a) => a.meta_window)
      .find((w) => w.has_focus());
    if (win) {
      win.move_resize_frame(0, x, y, width, height);
    }
  }
}

function init() {
  return new Extension();
}
