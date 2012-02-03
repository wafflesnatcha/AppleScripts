try
	tell application (name of application (path to frontmost application as Unicode text))
		close first window
	end tell
end try