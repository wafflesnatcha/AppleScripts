tell application "System Events"
	try
		tell (first process whose frontmost is true)
			tell (first button whose description is "Close") of first window
				perform (first action whose name is "AXPress")
			end tell
		end tell
	end try
end tell