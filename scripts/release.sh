#!/usr/bin/env bash
# Release script: updates a plugin version across both repos
# Usage: ./scripts/release.sh <plugin-name> <version>
# Example: ./scripts/release.sh patrol 2.1.0
set -euo pipefail

PLUGIN="$1"
VERSION="$2"
REGISTRY_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -z "$PLUGIN" ] || [ -z "$VERSION" ]; then
  echo "Usage: $0 <plugin-name> <version>"
  echo "Example: $0 patrol 2.1.0"
  exit 1
fi

PLUGIN_DIR="$REGISTRY_ROOT/plugins/$PLUGIN"
if [ ! -d "$PLUGIN_DIR" ]; then
  echo "Error: plugin '$PLUGIN' not found at $PLUGIN_DIR"
  exit 1
fi

echo "Releasing $PLUGIN v$VERSION"
echo ""

# 1. Update submodule to latest main
echo "→ Updating submodule to latest main..."
git -C "$PLUGIN_DIR" fetch origin
git -C "$PLUGIN_DIR" checkout origin/main

# Verify the plugin repo has the right version
PLUGIN_VERSION=$(jq -r '.version' "$PLUGIN_DIR/.claude-plugin/plugin.json" 2>/dev/null)
if [ "$PLUGIN_VERSION" != "$VERSION" ]; then
  echo "⚠ Warning: plugin.json says v$PLUGIN_VERSION but you requested v$VERSION"
  echo "  Update $PLUGIN's plugin.json first, then re-run this script."
  exit 1
fi

# 2. Update marketplace.json version
echo "→ Updating marketplace.json..."
MARKETPLACE="$REGISTRY_ROOT/.claude-plugin/marketplace.json"
tmp=$(mktemp "${MARKETPLACE}.XXXXXX")
jq --arg name "$PLUGIN" --arg ver "$VERSION" \
  '(.plugins[] | select(.name == $name)).version = $ver' \
  "$MARKETPLACE" > "$tmp" && mv "$tmp" "$MARKETPLACE"

# 3. Also sync description from plugin's marketplace.json if it exists
PLUGIN_MARKETPLACE="$PLUGIN_DIR/.claude-plugin/marketplace.json"
if [ -f "$PLUGIN_MARKETPLACE" ]; then
  PLUGIN_DESC=$(jq -r ".plugins[0].description // empty" "$PLUGIN_MARKETPLACE" 2>/dev/null)
  if [ -n "$PLUGIN_DESC" ]; then
    tmp=$(mktemp "${MARKETPLACE}.XXXXXX")
    jq --arg name "$PLUGIN" --arg desc "$PLUGIN_DESC" \
      '(.plugins[] | select(.name == $name)).description = $desc' \
      "$MARKETPLACE" > "$tmp" && mv "$tmp" "$MARKETPLACE"
    echo "→ Synced description from plugin repo"
  fi
fi

# 4. Commit and push
echo "→ Committing..."
git -C "$REGISTRY_ROOT" add ".claude-plugin/marketplace.json" "plugins/$PLUGIN"
git -C "$REGISTRY_ROOT" commit -m "Release $PLUGIN v$VERSION"
git -C "$REGISTRY_ROOT" push origin main

echo ""
echo "✅ $PLUGIN v$VERSION released"
echo "   Run: claude plugin marketplace update cukas"
