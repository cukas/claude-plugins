#!/usr/bin/env bash
# Install git hooks for the marketplace repo
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cp "$REPO_ROOT/scripts/pre-commit-version-sync.sh" "$REPO_ROOT/.git/hooks/pre-commit"
chmod +x "$REPO_ROOT/.git/hooks/pre-commit"
echo "Hooks installed."
