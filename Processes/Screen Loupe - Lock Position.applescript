on run argv
	if application id "com.artissoftware.screenlupe" is running then
		activate application id "com.artissoftware.screenlupe"
		tell application "System Events" to keystroke "l" using {command down}
	end if
end run