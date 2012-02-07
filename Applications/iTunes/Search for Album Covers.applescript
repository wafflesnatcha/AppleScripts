property lib : load script (POSIX path of (path to scripts folder) & "lib/lib.scpt")

property my_title : "Google Lyric Search"
property baseURL : "http://www.google.com/images?q="

tell application "iTunes"
	if selection is not {} then
		set _track to (item 1 of selection)
	else if player state is not stopped then
		set _track to current track
	else
		display dialog return & "Nothing is playing or selected..." buttons {"Cancel"} default button 1 with icon 0 giving up after 15 with title my_title
		return
	end if
	
	try
		set _url to baseURL & URLEncode((artist of _track & " " & album of _track) & " album cover") of _Text of lib as text
		tell application "Finder" to open location _url
	on error error_message number error_number
		displayError(error_message, error_number) of lib
	end try
end tell