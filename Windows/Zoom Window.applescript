try
	tell application (name of application (path to frontmost application as Unicode text))
		if (zoomed of first window) is true then
			set zoomed of first window to false
		else
			set zoomed of first window to true
		end if
	end tell
end try