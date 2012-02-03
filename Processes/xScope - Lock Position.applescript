on run argv
	if application "xScope" is running then
		activate application "xScope"
		tell application "System Events" to keystroke "l" using {command down}
	end if
end run