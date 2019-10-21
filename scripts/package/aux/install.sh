#!/usr/bin/env bash

check_if_is_installed() {
   local -r package="$1"

   local -r fn="$(package::fn "$package" is_installed)"

   if platform::command_exists $fn; then
      $fn
   else
      platform::command_exists "$package"
   fi
}

install_if_not_installed() {
   local -r package="$1"

   local -r pkg_managers="$(dict::get "$OPTIONS" pkg_managers)"
   local map_fn="" install_fn="" map="" actual_package=""

   if check_if_is_installed "$package"; then
      echoerr "$package is already installed"
      return 0
   fi

   map_fn="${package}::map"

   if platform::command_exists $map_fn; then
      map="$($map_fn || echo "")"
   fi

   for pkg_manager in $pkg_managers; do
      install_fn="${package}::${pkg_manager}"
      actual_package="$(echo "$map" | dict::get "$pkg_manager" || echo "")"

      if [[ -n "$actual_package" ]] && "${pkg_manager}::install" "$actual_package"; then
         return 0
      elif platform::command_exists "$install_fn" && $install_fn; then
         return 0
      elif "${pkg_manager}::install" "$package"; then
         return 0
      fi
   done

   return 1
}

handler::install() {
   local -r packages="$(dict::get "$OPTIONS" values)"

   local failures=0

   for package in $packages; do
      package::load_custom_recipe "$package"
      if ! install_if_not_installed "$package"; then
         failures=$((failures+1))
      fi
   done

   return $failures
}
