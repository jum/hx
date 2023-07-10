#!/bin/sh
set -e -o pipefail
curl --clobber --remote-name --location $( \
	curl -s https://api.github.com/repos/bigskysoftware/htmx/releases/latest \
		| jq -j '.assets[]|select(.name == "htmx.js")|.browser_download_url' \
	)
# npm install uglify-js -g
uglifyjs htmx.js --source-map -o htmx.min.js
