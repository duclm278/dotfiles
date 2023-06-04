# Set up cargo
export PATH="$HOME/.cargo/bin:$PATH"

# Make systemd aware of modified PATH
systemctl --user import-environment PATH
