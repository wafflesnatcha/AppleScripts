try
	tell application (name of application (path to frontmost application as Unicode text)) to close first window
end try