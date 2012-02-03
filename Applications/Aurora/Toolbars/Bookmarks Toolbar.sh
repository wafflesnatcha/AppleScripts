#!/usr/bin/env bash
osascript <<EOF &>/dev/null
activate application id "org.mozilla.aurora"
try
    tell application "System Events" to tell application process "firefox" to click menu item "Bookmarks Toolbar" of first menu of menu item "Toolbars" of menu "View" of menu bar 1
end try
EOF
