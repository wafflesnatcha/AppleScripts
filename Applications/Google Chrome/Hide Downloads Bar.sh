#!/usr/bin/env bash
osascript -e 'tell application "System Events" to click (first button whose description is "Close") of first window of (first process whose frontmost is true)' &>/dev/null &

