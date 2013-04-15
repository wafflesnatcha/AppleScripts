#!/usr/bin/env bash
osascript <<APPLESCRIPT &>/dev/null &
with timeout of 5 seconds
	try
		activate application "MediaInfo"
		tell application "System Events" to tell application process "MediaInfo" to click menu item "HTML" of menu "View" of menu bar 1
	end try
end timeout
APPLESCRIPT
