save_proxy() {
  local dest=~/.config/proxy/current.ini
  [[ $# -eq 1 ]] && dest="$1"
  $(which install) -D -m 664 /dev/null "$dest"

  echo "HTTP_PROXY=${HTTP_PROXY:-}" >> "$dest"
  echo "HTTPS_PROXY=${HTTPS_PROXY:-}" >> "$dest"
  echo "FTP_PROXY=${FTP_PROXY:-}" >> "$dest"
  echo "SOCKS_PROXY=${SOCKS_PROXY:-}" >> "$dest"
  echo "NO_PROXY=${NO_PROXY:-}" >> "$dest"

  echo "http_proxy=\${HTTP_PROXY:-}" >> "$dest"
  echo "https_proxy=\${HTTPS_PROXY:-}" >> "$dest"
  echo "ftp_proxy=\${FTP_PROXY:-}" >> "$dest"
  echo "socks_proxy=\${SOCKS_PROXY:-}" >> "$dest"
  echo "no_proxy=\${NO_PROXY:-}" >> "$dest"

  echo "Proxy settings saved to $dest"
}

set_proxy() {
  if [[ $# -eq 1 ]]; then
    $(which install) -D -m 664 "$1" ~/.config/proxy/current.ini
  fi

  if [[ -f ~/.config/proxy/current.ini ]]; then
    set -o allexport
    source ~/.config/proxy/current.ini
    set +o allexport
    save_proxy
  fi

  # Set GNOME system proxy settings
  gsettings set org.gnome.system.proxy mode "manual"

  # HTTP_PROXY
  if [[ -n "$HTTP_PROXY" ]]; then
    gsettings set org.gnome.system.proxy.http host "$(echo "$HTTP_PROXY" | awk -F'[:/]' '{print $4}')"
    gsettings set org.gnome.system.proxy.http port "$(echo "$HTTP_PROXY" | awk -F'[:/]' '{print $5}')"
  fi

  # HTTPS_PROXY
  if [[ -n "$HTTPS_PROXY" ]]; then
    gsettings set org.gnome.system.proxy.https host "$(echo "$HTTPS_PROXY" | awk -F'[:/]' '{print $4}')"
    gsettings set org.gnome.system.proxy.https port "$(echo "$HTTPS_PROXY" | awk -F'[:/]' '{print $5}')"
  fi

  # FTP_PROXY
  if [[ -n "$FTP_PROXY" ]]; then
    gsettings set org.gnome.system.proxy.ftp host "$(echo "$FTP_PROXY" | awk -F'[:/]' '{print $4}')"
    gsettings set org.gnome.system.proxy.ftp port "$(echo "$FTP_PROXY" | awk -F'[:/]' '{print $5}')"
  fi

  # SOCKS_PROXY
  if [[ -n "$SOCKS_PROXY" ]]; then
    gsettings set org.gnome.system.proxy.socks host "$(echo "$SOCKS_PROXY" | awk -F'[:/]' '{print $4}')"
    gsettings set org.gnome.system.proxy.socks port "$(echo "$SOCKS_PROXY" | awk -F'[:/]' '{print $5}')"
  fi

  # NO_PROXY
  gsettings set org.gnome.system.proxy ignore-hosts "['${NO_PROXY:-}']"

  echo "Proxy settings set"
}

unset_proxy() {
  unset HTTP_PROXY HTTPS_PROXY FTP_PROXY SOCKS_PROXY NO_PROXY \
      http_proxy https_proxy ftp_proxy socks_proxy no_proxy
  save_proxy

  # Reset GNOME system proxy settings
  gsettings reset-recursively org.gnome.system.proxy

  echo "Proxy settings unset"
}

set_proxy >/dev/null 2>&1
