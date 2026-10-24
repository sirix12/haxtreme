#!/usr/bin/env bash
# Scaffold a new problem directory from templates/main.cpp.
# Usage: scripts/new-problem.sh <slug> ["Problem Title"]
set -euo pipefail

if [[ $# -lt 1 ]]; then
    echo "usage: $0 <slug> [\"Problem Title\"]" >&2
    exit 2
fi

slug=$1
title=${2:-"$slug"}
root=$(cd "$(dirname "$0")/.." && pwd)
dir="$root/solutions/$slug"

if [[ -e "$dir" ]]; then
    echo "error: $dir already exists" >&2
    exit 1
fi

mkdir -p "$dir/tests"
cp "$root/templates/main.cpp" "$dir/solution.cpp"
touch "$dir/tests/01.in" "$dir/tests/01.ans"

cat > "$dir/README.md" <<EOF
# $title

- **Link:** TODO
- **Constraints:** TODO

## Approach

TODO

## Complexity

- Time: TODO
- Space: TODO
EOF

echo "Created $dir"
