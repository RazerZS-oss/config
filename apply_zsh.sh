#!/usr/bin/env bash
#
# apply_zsh.sh - Safely backup and apply optimized modules to ~/.zshrc.d/
#

set -euo pipefail

DEST_DIR="$HOME/.zshrc.d"
SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ ! -d "$DEST_DIR" ]]; then
  echo "Error: Directory $DEST_DIR not found."
  exit 1
fi

echo "==> Backing up original files to ~/.zshrc.d/*.bak ..."
[[ -f "$DEST_DIR/10-env.zsh" ]] && cp "$DEST_DIR/10-env.zsh" "$DEST_DIR/10-env.zsh.bak"
[[ -f "$DEST_DIR/20-completion.zsh" ]] && cp "$DEST_DIR/20-completion.zsh" "$DEST_DIR/20-completion.zsh.bak"

echo "==> Copying optimized files..."
cp "$SRC_DIR/10-env.zsh" "$DEST_DIR/10-env.zsh"
cp "$SRC_DIR/20-completion.zsh" "$DEST_DIR/20-completion.zsh"

echo "==> Done!"
echo "Run 'source ~/.zshrc' or open a new terminal window to test."
