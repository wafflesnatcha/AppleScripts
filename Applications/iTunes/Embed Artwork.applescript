(*
"Embed Artwork" for iTunes 7 or better
written by Brian Webster

- v2.0 sept 29 2009 (D.A.)
- maintenance release
- saved as bundle/universal binary

- v1.1 sept 25 2006
- added routine to check for a selection, account for de-selection of tracks (D.A.)

- v1.0 sept 25 2006
- initial release
*)

tell application "iTunes"
	if selection is not {} then
		set sel to selection
		with timeout of 300000 seconds
			repeat with aTrack in sel
				repeat with anArtwork in artworks of aTrack
					if downloaded of anArtwork is true then
						set theData to data of anArtwork
						set data of anArtwork to theData
					end if
				end repeat
			end repeat
		end timeout
	else
		display dialog "Select some tracks first..." buttons {"Cancel"} default button 1 with icon 2 giving up after 15
	end if
end tell
