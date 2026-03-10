#!/usr/bin/env bash
# Pre-commit hook: sync plugin versions from plugin.json → marketplace.json
# Ensures marketplace.json always reflects the actual plugin version.

set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel)"
MARKETPLACE="$REPO_ROOT/.claude-plugin/marketplace.json"

[ -f "$MARKETPLACE" ] || exit 0
command -v jq >/dev/null 2>&1 || { echo "pre-commit: jq required for version sync" >&2; exit 0; }

CHANGED=false

for plugin_dir in "$REPO_ROOT"/plugins/*/; do
  PLUGIN_JSON="$plugin_dir/.claude-plugin/plugin.json"
  [ -f "$PLUGIN_JSON" ] || continue

  NAME=$(jq -r '.name' "$PLUGIN_JSON")
  SOURCE_VERSION=$(jq -r '.version' "$PLUGIN_JSON")
  MARKET_VERSION=$(jq -r --arg n "$NAME" '.plugins[] | select(.name == $n) | .version' "$MARKETPLACE")

  if [ "$SOURCE_VERSION" != "$MARKET_VERSION" ]; then
    echo "pre-commit: syncing $NAME version $MARKET_VERSION → $SOURCE_VERSION"
    tmp=$(mktemp "${MARKETPLACE}.XXXXXX")
    jq --arg n "$NAME" --arg v "$SOURCE_VERSION" \
      '(.plugins[] | select(.name == $n)).version = $v' \
      "$MARKETPLACE" > "$tmp" && mv "$tmp" "$MARKETPLACE"
    CHANGED=true
  fi
done

if [ "$CHANGED" = true ]; then
  git add "$MARKETPLACE"
fi
