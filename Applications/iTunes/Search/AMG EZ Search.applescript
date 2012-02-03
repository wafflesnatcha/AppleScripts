(*
You can rename this script to whatever you want
but please keep this information intact. Thanks.

"AMG EZ Search" for iTunes
written by Doug Adams
dougscripts@mac.com

v2.0 
-- Universal binary/bundle
-- updated for changes to search at AMG
-- generally updated

v1.5 December 8, 2005
-- convert space in search strings to "|" (pipe) -- AMG likes this

v1.4 June 6, 2005
-- fix for new AMG URL

v1.3 October 4, 2004
-- fix for TITLE change of AMG pages
-- fixes error if no window open in Safari

v1.2 August  28 04
-- changed the conversion of space characters to "." 
-- rather than old version "+"
-- which seems more effective

v1.1 July 19 04
-- adjusted for AMG's new search format

april 21 2004
initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
dougscripts.com

This program is free software released "as-is"; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

*)

property my_title : "AMG EZ Search"
property baseURL : "http://www.allmusic.com/search"

tell application "iTunes"
	set {curTrack, selTrack} to {{}, {}}
	try
		set sel to selection
		if sel is not {} and length of sel is 1 then set selTrack to (item 1 of selection)
	end try
	try
		if player state is not stopped then set curTrack to current track
	end try
	-- both empty?	
	if {curTrack, selTrack} is {{}, {}} then
		display dialog return & "Nothing is playing or selected..." buttons {"Cancel"} default button 1 with icon 0 giving up after 15 with title my_title
		return
	end if
	-- decide which is preferred
	if curTrack is {} then set theTrack to selTrack
	if selTrack is {} then set theTrack to curTrack
	--
	if curTrack is not {} and selTrack is not {} then
		if (get persistent ID of curTrack) is not (get persistent ID of selTrack) then
			-- they are different
			set opt to button returned of (display dialog "Search on selected or playing track?" buttons {"Cancel", "Playing", "Selected"} with icon 1 with title my_title)
			if opt is "selected" then
				set theTrack to selTrack
			else
				set theTrack to curTrack
			end if
		else -- no diff
			set theTrack to selTrack
		end if
	end if
	-- 
	try
		-- is curTrack stream?
		if (get class of theTrack) is URL track and player state is playing then
			-- search for stream stuff -- just search on artist, no selection of tags choose list
			set {a, t} to my text_to_list((get current stream title), " - ")
			my do_radiosearch(a)
			return
		end if
		--
		tell theTrack to set {art, alb, n} to {get artist, get album, get name}
	on error
		display dialog return & "Unable to access the track info..." buttons {"Cancel"} default button 1 with icon 0 giving up after 15 with title my_title
		return
	end try
	my prep_terms(art, alb, n)
end tell

to prep_terms(art, alb, n)
	set optionsList to {("Artist: " & art) as text, ("Album: " & alb) as text, ("Song Name: " & n) as text}
	set theChoice to (choose from list optionsList with prompt (tab & "Select a tag for search:") with title my_title)
	if theChoice is false then return
	set theChoice to item 1 of theChoice
	set theSearchOpt to ("/" & (first word of theChoice) & "/") as text
	set theSearchTerm to text ((offset of ":" in theChoice) + 2) thru -1 of theChoice
	my open_location((baseURL & theSearchOpt & my urlencode(theSearchTerm)) as text)
end prep_terms

to do_radiosearch(theSearchTerm)
	repeat
		set theSearchTerm to text returned of (display dialog "Clean up the search term?" default answer theSearchTerm with title my_title)
		if theSearchTerm is not "" then exit repeat
	end repeat
	my open_location((baseURL & "/artist/" & my urlencode(theSearchTerm)) as text)
end do_radiosearch

to open_location(t)
	try
		tell application "Finder" to open location t
	on error m
		display dialog m buttons {"Cancel"} default button 1 with icon 2 with title my_title giving up after 15
	end try
end open_location

on text_to_list(txt, delim)
	set saveD to text item delimiters
	try
		set text item delimiters to {delim}
		set theList to every text item of txt
	on error errStr number errNum
		set text item delimiters to saveD
		error errStr number errNum
	end try
	set text item delimiters to saveD
	return (theList)
end text_to_list

on urlencode(theText)
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
end urlencode
