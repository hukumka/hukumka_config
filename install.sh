#!/bin/sh

USAGE_MESSAGE="
Install configuration files to current user.

This script will override existing configuration.

Usage:
./install.sh TARGET1 TARGET2 TARGET3

Available targets:
  helix
  anyrun
  hypr
  fish
"

install_config () {
  if [ -z "$2" ]; then
    name=$1
  else
    name="$2"
  fi

  echo "Installing ${name} configuration into ~/.config/${1}"
  mkdir -p ~/.config/
  cp -r ./config/${1} ~/.config/

}

install_helix () {
  install_config "helix" "Helix editor"
  
  mkdir -p ~/.local/share/helix/  # Copy python stub files for pylance
  cp -r ./src/third-party/python-type-stubs/stubs/ ~/.local/share/helix/pyright-stubs
  echo "Done."
}

if [[ $# -eq 0 ]]; then
  echo "$USAGE_MESSAGE"
  exit;
fi

while [[ $# -gt 0 ]]; do
  case $1 in
    helix)
      install_helix
    ;;
    anyrun)
      install_config "anyrun"
    ;;
    hypr)
      install_config "hypr" "Hyprland"
    ;;
    *)
      echo "Unknown target ${1}"
    ;;
  esac
  shift
done
