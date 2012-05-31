tell application "iTunes"
	set _tracks to selection as list
	if _tracks is {} then
		display alert "Nothing selected!" as warning giving up after 5
		return
	end if
	repeat with _track in _tracks
		with timeout of 10 seconds
			try
				repeat with _art in artworks of _track
					if (not downloaded of _art) then
						delete _art
					end if
				end repeat
			on error error_message number error_number
				display alert "Error" message error_message as warning buttons {"OK"} default button 1
			end try
		end timeout
	end repeat
end tell