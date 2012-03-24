property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"

property base_url : "http://www.google.com/images?q="

tell application "iTunes"
	if selection is not {} then
		set _track to item 1 of selection
	else if player state is not stopped then
		set _track to current track
	else
		return
	end if
	
	try
		set _artist to artist of _track
		if album artist of _track is not "" then set _artist to album artist of _track
		set _url to base_url & URLEncode(_artist & " " & album of _track & " album cover") of _Text of lib as text
		tell application "System Events" to open location _url
	on error error_message number error_number
		displayError(error_message, error_number) of lib
	end try
end tell