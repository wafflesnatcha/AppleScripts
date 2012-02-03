(*
-- Refresh Track Data
-- update file track information from the current information in the track’s file
*)

tell application "iTunes"
	set _s to selection as list
	repeat with i in _s
		if (class of i) is file track then refresh i
	end repeat
end tell
