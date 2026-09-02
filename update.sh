#!/bin/sh
set -e

tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

url=$(curl -s https://api.github.com/repos/bigskysoftware/htmx/releases/latest \
	  | jq -r '.tarball_url')

curl -L "$url" | tar -xzf - -C "$tmpdir"

srcdir=$(find "$tmpdir" -mindepth 1 -maxdepth 1 -type d)

cp "$srcdir/dist/htmx.js" ./htmx.js

# npm install uglify-js -g

uglifyjs htmx.js --source-map -o htmx.min.js
