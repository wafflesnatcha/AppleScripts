try
	with timeout of 5 seconds
		tell application "System Events" to perform (first action whose name is "AXPress") of (first button whose description is "Close") of first window of (first process whose frontmost is true)
	end timeout
end try