#!/usr/bin/env bash
set -euo pipefail

package::install() {
   dot pkg add sqlite3
}
