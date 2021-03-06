#!/usr/bin/env bash
set -euo pipefail

source "${DOTFILES}/scripts/core/log.sh"

DEFAULT_DOTFILES="${HOME}/dotfiles"

package::is_installed() {
   return 1
}

_default_available() {
   [[ -f "${DEFAULT_DOTFILES}/bin/dot" ]]
}

_symlink() {
   if [ -d "$DEFAULT_DOTFILES" ]; then
      log::warning "Backing up existing dotfiles folder and cloning new dotfiles..."
      old_dotfiles=$(mktemp -u -d "${DOTFILES}_XXXX")
      mv "$DEFAULT_DOTFILES" "$old_dotfiles"
   fi

   ln -s "$DOTFILES" "$DEFAULT_DOTFILES"
}

package::install() {
   dot pkg add git

   cd "$DOTFILES"

   git submodule init || true
   git submodule update || true
   git submodule foreach git reset --hard || true
   git submodule foreach git checkout . || true
   git submodule foreach git pull origin master || true

   if ! _default_available; then
      _symlink
   fi
}
