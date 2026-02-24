# Set up cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Make systemd aware of modified PATH
systemctl --user import-environment PATH

# Fix theming
export QT_QPA_PLATFORM="xcb"
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Set up fcitx5
if command -v fcitx5 > /dev/null; then
    export GTK_IM_MODULE=fcitx
    export QT_IM_MODULE=fcitx
    export XMODIFIERS=@im=fcitx
    export SDL_IM_MODULE=fcitx
    export GLFW_IM_MODULE=fcitx
fi
