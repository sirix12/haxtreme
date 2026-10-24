#!/usr/bin/env bash
# Compile a solution and compare its output against every tests/*.ans file.
# Usage: scripts/test.sh solutions/<problem-slug>
set -euo pipefail

if [[ $# -ne 1 ]]; then
    echo "usage: $0 solutions/<problem-slug>" >&2
    exit 2
fi

dir=${1%/}
src="$dir/solution.cpp"

if [[ ! -f "$src" ]]; then
    echo "error: $src not found" >&2
    exit 2
fi

if ! command -v g++ >/dev/null 2>&1; then
    echo "error: g++ not installed" >&2
    exit 2
fi

bin=$(mktemp)
trap 'rm -f "$bin" "$actual"' EXIT
actual=$(mktemp --suffix=.txt)

echo "Compiling $src"
g++ -std=c++20 -O2 -pipe -Wall -Wextra "$src" -o "$bin"

shopt -s nullglob
tests=("$dir"/tests/*.in)
if [[ ${#tests[@]} -eq 0 ]]; then
    echo "warning: no tests found in $dir/tests" >&2
    exit 1
fi

fail=0
for input in "${tests[@]}"; do
    expected="${input%.in}.ans"
    name=$(basename "$input" .in)

    if [[ ! -f "$expected" ]]; then
        echo "SKIP  $name (missing ${expected##*/})"
        continue
    fi

    "$bin" < "$input" > "$actual"

    if diff -q -B -Z "$expected" "$actual" >/dev/null; then
        echo "PASS  $name"
    else
        echo "FAIL  $name"
        diff -B -Z "$expected" "$actual" | sed 's/^/      /' || true
        fail=1
    fi
done

exit "$fail"
