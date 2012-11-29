tell application "iTunes"
	set _selection to selection as list
	repeat with s in _selection
		set enabled of s to (not enabled of s)
	end repeat
end tell