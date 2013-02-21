#!/usr/bin/env bash
osascript <<EOF &>/dev/null &
tell application "System Events"
	activate
	choose color
	quit
end tell
EOF