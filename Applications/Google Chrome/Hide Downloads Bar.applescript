tell application "System Events"
	try
		tell (first process whose frontmost is true)
			perform (first action whose name is "AXPress") of (first button whose description is "Close") of first window
		end tell
	end try
end tell