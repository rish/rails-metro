#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
TAP_DIR="${HOMEBREW_TAP_DIR:-$HOME/dev/homebrew-tap}"

VERSION=$(ruby -r "$REPO_ROOT/lib/rails/metro/version" -e "puts Rails::Metro::VERSION")

if [ ! -d "$TAP_DIR" ]; then
  echo "error: Homebrew tap directory not found at $TAP_DIR"
  echo "Set HOMEBREW_TAP_DIR or clone rish/homebrew-tap to ~/dev/homebrew-tap"
  exit 1
fi

echo "Updating Homebrew tap to metro $VERSION..."

cp "$REPO_ROOT/packaging/homebrew/metro.rb" "$TAP_DIR/Formula/metro.rb"

cd "$TAP_DIR"
git add Formula/metro.rb
git commit -m "metro $VERSION"
git push

echo "Done. Verify with: brew upgrade rish/tap/metro && metro version"
