# Set up cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Make systemd aware of modified PATH
systemctl --user import-environment PATH

# Fix theming
export QT_QPA_PLATFORM="xcb"
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
