#!/usr/bin/env bash
set -euo pipefail

source "${DOTFILES}/scripts/core/platform.sh"

package::is_installed() {
   ! platform::is_osx \
      || has ggrep
}

package::install() {
   dot pkg add brew

   brew tap homebrew/dupes
   brew install binutils diffutils findutils gawk gnu-indent gnu-sed gnu-tar gnu-which gnutls grep gzip wget
   brew install wdiff --with-gettext
   brew install m4 make nano file-formula
}