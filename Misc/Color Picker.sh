#!/usr/bin/env bash
osascript <<EOF &>/dev/null &
tell current application
	activate
	choose color
end tell
EOF