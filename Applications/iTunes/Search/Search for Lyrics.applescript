

(*
You can rename this script to whatever you want
but please keep this information intact. Thanks.

"Google Lyric Search" for iTunes
written by Doug Adams
dougscripts@mac.com

v2.0 sep 28 2010
- updated for modern iTunes
- universal binary

v1.2 jan 22 2006
- minor update

v1.0 oct 8 2004
- initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
dougscripts.com

This program is free software released "as-is"; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

*)

property my_title : "Google Lyric Search"
property baseURL : "http://www.google.com/search?q=lyrics+"

tell application "iTunes"
	if selection is not {} then
		set theTrack to (item 1 of selection)
	else if player state is not stopped then
		set theTrack to current track
	else
		display dialog return & "Nothing is playing or selected..." buttons {"Cancel"} default button 1 with icon 0 giving up after 15 with title my_title
		return
	end if
	
	try
		tell theTrack to set {nom, art} to {get name, get artist}
	on error
		display dialog return & "Unable to access the track info..." buttons {"Cancel"} default button 1 with icon 0 giving up after 15 with title my_title
		return
	end try
	my open_location(baseURL & my URLEncode(art & " " & nom) as text)
end tell

to open_location(theURL)
	tell application "Finder" to open location theURL
end open_location

on URLEncode(theText)
	-- this routine from
	-- http://harvey.nu/applescript_url_encode_routine.html
	set theTextEnc to ""
	repeat with eachChar in characters of theText
		set useChar to eachChar
		set eachCharNum to ASCII number of eachChar
		if eachCharNum = 32 then
			set useChar to "+"
		else if (eachCharNum ­ 42) and (eachCharNum ­ 95) and (eachCharNum < 45 or eachCharNum > 46) and (eachCharNum < 48 or eachCharNum > 57) and (eachCharNum < 65 or eachCharNum > 90) and (eachCharNum < 97 or eachCharNum > 122) then
			set firstDig to round (eachCharNum / 16) rounding down
			set secondDig to eachCharNum mod 16
			if firstDig > 9 then
				set aNum to firstDig + 55
				set firstDig to ASCII character aNum
			end if
			if secondDig > 9 then
				set aNum to secondDig + 55
				set secondDig to ASCII character aNum
			end if
			set numHex to ("%" & (firstDig as string) & (secondDig as string)) as string
			set useChar to numHex
		end if
		set theTextEnc to theTextEnc & useChar as string
	end repeat
	return theTextEnc
end URLEncode
