(* 
"Search SlothRadio for Artwork" v1.1
based on routines in Google Lyric Search 
written by Doug Adams and Adam Glinsky

- v1.1 aug 13, 2007
- changed text to identify title of SlothRadio page; prevents new Safari window from opening on successive uses.

- v1.0 february 9 2005
- initial release

Get more free AppleScripts for iTunes and
help writing your own:
http://www.malcolmadams.com/itunes/
*)
property baseURL : "http://www.slothradio.com/covers/?adv=&artist="

tell application "iTunes"
	
	-- get a reference to playing or selected track
	if selection is not {} then
		set theTrack to (item 1 of selection)
	else if player state is not stopped then
		set theTrack to current track
	else
		display dialog "Nothing is playing or selected." buttons {"Cancel"} Â
			default button 1 with icon 0
	end if
	
	-- get the name and artist and replace "bad" characters
	tell theTrack
		set alb to my fixChars(album)
		set art to my fixChars(artist)
	end tell
	
	-- assemble URL string, replace spaces with "+"
	set theURL to (baseURL & Â
		(my replace_chars((art & "&album=" & alb), " ", "+"))) as text
	
	my open_location(theURL)
	
end tell

on fixChars(a)
	set myDelims to {"!", "@", "#", "$", "%", "^", "&", "*", Â
		"(", ")", "-", "-", "+", "=", ":", ";", "'", ",", ".", "/", Â
		"<", ">", "?", "{", "}", "[", "]"}
	repeat with curDelim in myDelims
		set AppleScript's text item delimiters to curDelim
		set s to every text item of a
		set AppleScript's text item delimiters to {""}
		set a to s as string
	end repeat
	return a
end fixChars

on replace_chars(txt, srch, repl)
	set AppleScript's text item delimiters to the srch
	set the item_list to every text item of txt
	set AppleScript's text item delimiters to the repl
	set txt to the item_list as string
	set AppleScript's text item delimiters to ""
	return txt
end replace_chars

to open_location(theURL)
	open location theURL
end open_location
