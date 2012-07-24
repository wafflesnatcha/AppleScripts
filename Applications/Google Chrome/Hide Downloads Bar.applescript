with timeout of 5 seconds
	try
		tell application "System Events" to click (first button whose description is "Close") of first window of (first process whose frontmost is true)
	end try
end timeout