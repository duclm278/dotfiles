#!/bin/env bash

save_proxy() {
  local target="${1:-$HOME/.config/proxy/current.sh}"
  local opened="${target}"
  [[ -L "${opened}" ]] && opened=$(readlink -f "${opened}")
  install -D -m 664 /dev/null "${opened}"

  {
    printf 'HTTP_PROXY="%s"\n' "${HTTP_PROXY}"
    printf 'HTTPS_PROXY="%s"\n' "${HTTPS_PROXY}"
    printf 'FTP_PROXY="%s"\n' "${FTP_PROXY}"
    printf 'SOCKS_PROXY="%s"\n' "${SOCKS_PROXY}"
    printf 'NO_PROXY="%s"\n' "${NO_PROXY}"

    printf 'http_proxy="${HTTP_PROXY:-}"\n'
    printf 'https_proxy="${HTTPS_PROXY:-}"\n'
    printf 'ftp_proxy="${FTP_PROXY:-}"\n'
    printf 'socks_proxy="${SOCKS_PROXY:-}"\n'
    printf 'no_proxy="${NO_PROXY:-}"\n'
  } >> "${opened}"

  echo "Proxy settings saved to ${target}"
}

set_proxy() {
  local target="$HOME/.config/proxy/current.sh"
  if [[ $# -eq 1 ]]; then
    install -D -m 664 "$1" "${target}"
  fi

  if [[ -f "${target}" ]]; then
    set -o allexport
    source "${target}"
    set +o allexport
    save_proxy
  fi

  # Set GNOME system proxy settings
  gsettings set org.gnome.system.proxy mode "manual"

  # HTTP_PROXY
  if [[ -n "${HTTP_PROXY}" ]]; then
    gsettings set org.gnome.system.proxy.http host "$(echo "${HTTP_PROXY}" | awk -F'[:/]' '{print $4}')"
    gsettings set org.gnome.system.proxy.http port "$(echo "${HTTP_PROXY}" | awk -F'[:/]' '{print $5}')"
  fi

  # HTTPS_PROXY
  if [[ -n "${HTTPS_PROXY}" ]]; then
    gsettings set org.gnome.system.proxy.https host "$(echo "${HTTPS_PROXY}" | awk -F'[:/]' '{print $4}')"
    gsettings set org.gnome.system.proxy.https port "$(echo "${HTTPS_PROXY}" | awk -F'[:/]' '{print $5}')"
  fi

  # FTP_PROXY
  if [[ -n "${FTP_PROXY}" ]]; then
    gsettings set org.gnome.system.proxy.ftp host "$(echo "${FTP_PROXY}" | awk -F'[:/]' '{print $4}')"
    gsettings set org.gnome.system.proxy.ftp port "$(echo "${FTP_PROXY}" | awk -F'[:/]' '{print $5}')"
  fi

  # SOCKS_PROXY
  if [[ -n "${SOCKS_PROXY}" ]]; then
    gsettings set org.gnome.system.proxy.socks host "$(echo "${SOCKS_PROXY}" | awk -F'[:/]' '{print $4}')"
    gsettings set org.gnome.system.proxy.socks port "$(echo "${SOCKS_PROXY}" | awk -F'[:/]' '{print $5}')"
  fi

  # NO_PROXY
  local NO_ARRAY
  IFS="," 
  for entry in ${NO_PROXY}; do
    NO_ARRAY+=("'${entry}'")
  done
  NO_ARRAY="${NO_ARRAY:1}"
  gsettings set org.gnome.system.proxy ignore-hosts "[${NO_ARRAY}]"

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

  if [[ "${mode}" == "'manual'" ]]; then
    # Extract proxy host and port values from gsettings
    local HTTP_HOST=$(gsettings get org.gnome.system.proxy.http host | tr -d "'")
    local HTTP_PORT=$(gsettings get org.gnome.system.proxy.http port | tr -d "'")
    local HTTPS_HOST=$(gsettings get org.gnome.system.proxy.https host | tr -d "'")
    local HTTPS_PORT=$(gsettings get org.gnome.system.proxy.https port | tr -d "'")
    local FTP_HOST=$(gsettings get org.gnome.system.proxy.ftp host | tr -d "'")
    local FTP_PORT=$(gsettings get org.gnome.system.proxy.ftp port | tr -d "'")
    local SOCKS_HOST=$(gsettings get org.gnome.system.proxy.socks host | tr -d "'")
    local SOCKS_PORT=$(gsettings get org.gnome.system.proxy.socks port | tr -d "'")

    # HTTP_PROXY
    if [[ -z "${HTTP_HOST}" || -z "${HTTP_PORT}" ]]; then
      HTTP_PROXY=""
    else
      HTTP_PROXY="http://${HTTP_HOST}:${HTTP_PORT}/"
    fi

    # HTTPS_PROXY
    if [[ -z "${HTTPS_HOST}" || -z "${HTTPS_PORT}" ]]; then
      HTTPS_PROXY=""
    else
      HTTPS_PROXY="http://${HTTPS_HOST}:${HTTPS_PORT}/"
    fi

    # FTP_PROXY
    if [[ -z "${FTP_HOST}" || -z "${FTP_PORT}" ]]; then
      FTP_PROXY=""
    else
      FTP_PROXY="http://${FTP_HOST}:${FTP_PORT}/"
    fi

    # SOCKS_PROXY
    if [[ -z "${SOCKS_HOST}" || -z "${SOCKS_PORT}" ]]; then
      SOCKS_PROXY=""
    else
      SOCKS_PROXY="http://${SOCKS_HOST}:${SOCKS_PORT}/"
    fi

    # Pass proxy values to save_proxy
    HTTP_PROXY="${HTTP_PROXY}" \
      HTTPS_PROXY="${HTTPS_PROXY}" \
      FTP_PROXY="${FTP_PROXY}" \
      SOCKS_PROXY="${SOCKS_PROXY}" \
      NO_PROXY=$(gsettings get org.gnome.system.proxy ignore-hosts | tr -d "[]' ") \
      save_proxy >/dev/null 2>&1
    set_proxy
  elif [[ "${mode}" == "'none'" ]]; then
    unset_proxy
  else
    echo "Unknown proxy mode: ${mode}"
  fi
}

sync_proxy >/dev/null 2>&1
