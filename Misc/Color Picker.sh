#!/usr/bin/env bash
osascript <<EOF &
tell application "System Events"
	activate
	try
		return choose color default color argv
	on error
		return choose color
	end try
end tell
EOF