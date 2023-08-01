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

  # Remove square brackets
  local NO_PROXY="${NO_PROXY:-}"
  NO_PROXY=${NO_PROXY#\[}
  NO_PROXY=${NO_PROXY%\]}

  # Convert comma-separated values into array
  local NO_PROXY_ARRAY=
  IFS=',' read -A NO_PROXY_ARRAY <<< "$NO_PROXY"
  JOINED=$(printf ",'%s'" "${NO_PROXY_ARRAY[@]}")

  # NO_PROXY
  gsettings set org.gnome.system.proxy ignore-hosts "[${JOINED:1}]"

  echo "Proxy settings set"
}

unset_proxy() {
  unset HTTP_PROXY HTTPS_PROXY FTP_PROXY SOCKS_PROXY NO_PROXY \
      http_proxy https_proxy ftp_proxy socks_proxy no_proxy
  save_proxy


  # Unset GNOME system proxy settings
  # gsettings reset-recursively org.gnome.system.proxy
  gsettings set org.gnome.system.proxy mode "none"

  echo "Proxy settings unset"
}

sync_proxy() {
  # Check GNOME system proxy mode
  local mode=$(gsettings get org.gnome.system.proxy mode)

  if [[ "$mode" == "'manual'" ]]; then
    # Extract proxy host and port values from gsettings
    local HTTP_PROXY_HOST=$(gsettings get org.gnome.system.proxy.http host | tr -d "'")
    local HTTP_PROXY_PORT=$(gsettings get org.gnome.system.proxy.http port | tr -d "'")
    local HTTPS_PROXY_HOST=$(gsettings get org.gnome.system.proxy.https host | tr -d "'")
    local HTTPS_PROXY_PORT=$(gsettings get org.gnome.system.proxy.https port | tr -d "'")
    local FTP_PROXY_HOST=$(gsettings get org.gnome.system.proxy.ftp host | tr -d "'")
    local FTP_PROXY_PORT=$(gsettings get org.gnome.system.proxy.ftp port | tr -d "'")
    local SOCKS_PROXY_HOST=$(gsettings get org.gnome.system.proxy.socks host | tr -d "'")
    local SOCKS_PROXY_PORT=$(gsettings get org.gnome.system.proxy.socks port | tr -d "'")

    # HTTP_PROXY
    if [ -z "$HTTP_PROXY_HOST" ] || [ -z "$HTTP_PROXY_PORT" ]; then
      HTTP_PROXY=""
    else
      HTTP_PROXY="http://${HTTP_PROXY_HOST}:${HTTP_PROXY_PORT}/"
    fi

    # HTTPS_PROXY
    if [ -z "$HTTPS_PROXY_HOST" ] || [ -z "$HTTPS_PROXY_PORT" ]; then
      HTTPS_PROXY=""
    else
      HTTPS_PROXY="http://${HTTPS_PROXY_HOST}:${HTTPS_PROXY_PORT}/"
    fi

    # FTP_PROXY
    if [ -z "$FTP_PROXY_HOST" ] || [ -z "$FTP_PROXY_PORT" ]; then
      FTP_PROXY=""
    else
      FTP_PROXY="http://${FTP_PROXY_HOST}:${FTP_PROXY_PORT}/"
    fi

    # SOCKS_PROXY
    if [ -z "$SOCKS_PROXY_HOST" ] || [ -z "$SOCKS_PROXY_PORT" ]; then
      SOCKS_PROXY=""
    else
      SOCKS_PROXY="http://${SOCKS_PROXY_HOST}:${SOCKS_PROXY_PORT}/"
    fi

    # Pass proxy values to save_proxy
    HTTP_PROXY="$HTTP_PROXY" \
      HTTPS_PROXY="$HTTPS_PROXY" \
      FTP_PROXY="$FTP_PROXY" \
      SOCKS_PROXY="$SOCKS_PROXY" \
      NO_PROXY=$(gsettings get org.gnome.system.proxy ignore-hosts | tr -d "[]' ") \
      save_proxy >/dev/null 2>&1
    set_proxy
  elif [[ "$mode" == "'none'" ]]; then
    unset_proxy
  else
    echo "Unknown proxy mode: $mode"
  fi
}

sync_proxy >/dev/null 2>&1
