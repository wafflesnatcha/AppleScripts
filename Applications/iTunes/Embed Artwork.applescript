tell application "iTunes"
	set _tracks to selection as list
	if _tracks is {} then
		display alert "Nothing selected!" as warning giving up after 5
		return
	end if
	repeat with _track in _tracks
		with timeout of 10 seconds
			repeat with _art in artworks of _track
				if downloaded of _art then
					set _data to data of _art
					set data of _art to _data
				end if
			end repeat
		end timeout
	end repeat
end tell