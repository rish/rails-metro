#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
AUR_DIR="${AUR_DIR:-$HOME/dev/aur-rails-metro}"

VERSION=$(ruby -r "$REPO_ROOT/lib/rails/metro/version" -e "puts Rails::Metro::VERSION")

if [ ! -d "$AUR_DIR" ]; then
  echo "error: AUR directory not found at $AUR_DIR"
  echo "Set AUR_DIR or clone ssh://aur@aur.archlinux.org/ruby-rails-metro.git to ~/dev/aur-rails-metro"
  exit 1
fi

echo "Updating AUR package to ruby-rails-metro $VERSION..."

cp "$REPO_ROOT/packaging/aur/PKGBUILD" "$AUR_DIR/PKGBUILD"
cp "$REPO_ROOT/packaging/aur/.SRCINFO" "$AUR_DIR/.SRCINFO"

cd "$AUR_DIR"
git add PKGBUILD .SRCINFO
git commit -m "Upgrade to $VERSION"
git push origin master

echo "Done. Live at: https://aur.archlinux.org/packages/ruby-rails-metro"
