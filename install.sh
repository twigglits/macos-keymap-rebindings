#!/usr/bin/env bash
#
# install.sh — Install the Windows-style Karabiner-Elements keymap on this Mac.
#
# Copies the karabiner.json sitting next to this script into the Karabiner-Elements
# config directory (~/.config/karabiner/), backing up any existing config first.
#
# Usage: ./install.sh   (run from anywhere — the script finds its own folder)
#
set -euo pipefail

case "${1:-}" in
  -h|--help)
    cat <<'EOF'
install.sh — Install the Windows-style Karabiner-Elements keymap.

Copies karabiner.json (next to this script) into ~/.config/karabiner/,
saving a timestamped backup of any existing config first.

Requires: macOS with Karabiner-Elements installed.
Usage:    ./install.sh
EOF
    exit 0
    ;;
esac

# --- Paths -------------------------------------------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$SCRIPT_DIR/karabiner.json"
CONFIG_DIR="$HOME/.config/karabiner"
DEST="$CONFIG_DIR/karabiner.json"
KARABINER_CLI="/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_cli"

# --- Output helpers ----------------------------------------------------------
info() { printf '\033[0;34m==>\033[0m %s\n' "$*"; }
ok()   { printf '\033[0;32m \xe2\x9c\x93\033[0m %s\n' "$*"; }
warn() { printf '\033[0;33m !\033[0m %s\n' "$*"; }
die()  { printf '\033[0;31m \xe2\x9c\x97 %s\033[0m\n' "$*" >&2; exit 1; }

# --- Pre-flight checks -------------------------------------------------------
[[ "$(uname -s)" == "Darwin" ]] || die "This installer is macOS-only (Karabiner-Elements is a macOS app)."
[[ -f "$SRC" ]] || die "Couldn't find karabiner.json next to this script (expected: $SRC)."

if [[ ! -d "/Applications/Karabiner-Elements.app" && ! -x "$KARABINER_CLI" ]]; then
  warn "Karabiner-Elements does not appear to be installed."
  {
    echo "    Install it first, then re-run this script:"
    echo "      brew install --cask karabiner-elements"
    echo "    …or download it from https://karabiner-elements.pqrs.org/"
  } >&2
  exit 1
fi
ok "Karabiner-Elements is installed."

# --- Validate the JSON before touching anything ------------------------------
# Note: `plutil -lint` can't parse JSON, but `plutil -convert` can — so we parse
# the file to /dev/null purely as a syntax check. plutil ships with every macOS.
if command -v plutil >/dev/null 2>&1; then
  if plutil -convert binary1 -o /dev/null "$SRC" >/dev/null 2>&1; then
    ok "karabiner.json parsed cleanly."
  else
    die "karabiner.json could not be parsed — aborting so your setup isn't left broken."
  fi
fi

# --- Install -----------------------------------------------------------------
mkdir -p "$CONFIG_DIR"

if [[ -f "$DEST" ]]; then
  BACKUP="$DEST.backup-$(date +%Y%m%d-%H%M%S)"
  cp "$DEST" "$BACKUP"
  warn "Existing config backed up to: $BACKUP"
fi

cp "$SRC" "$DEST"
ok "Installed keymap to $DEST"

# --- Done --------------------------------------------------------------------
echo
info "All set! Karabiner-Elements watches that file and reloads automatically."
echo "    If the shortcuts don't take effect, open Karabiner-Elements, confirm the"
echo "    \"Default profile\" is selected, and that Input Monitoring is granted under"
echo "    System Settings → Privacy & Security."
