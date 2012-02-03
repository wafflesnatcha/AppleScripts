(*
"Search Amazon Book Covers" for iTunes
written by Doug Adams
dougscripts@mac.com

v1.1 sep 13 2010
-- adds album as option for search

v1.0 aug 12 2010
-- initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
dougscripts.com

This program is free software released "as-is"; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

*)

property myTitle : "Search Amazon Book Covers"
property baseURL : "http://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Dstripbooks&x=0&y=0&field-keywords="

tell application "iTunes"
	try
		set sel to selection
		if sel is {} then
			display dialog return & "Select a single Book track first..." buttons {"Cancel"} default button 1 with icon 0 giving up after 15 with title my_title
			return
		end if
		tell item 1 of sel to my ping_amazon({name, artist, album, genre})
	end try
end tell

to ping_amazon({ttl, auth, alb, cat})
	set myList to {("Title: " & ttl) as text, ("Author: " & auth) as text, ("Album: " & alb) as text, ("Category: " & cat) as text}
	set myOpts to (choose from list myList default items {item 1 of myList, item 2 of myList} with prompt "Search Amazon Books using the selected keywords:" with title myTitle with multiple selections allowed)
	if myOpts is false then return
	
	set str to {}
	repeat with t in myOpts
		set end of str to my replace_chars(text ((offset of ": " in t as text) + 2) thru -1 of t as text, " ", "+")
	end repeat
	
	tell application "System Events" to open location (baseURL & my list_to_text(str, "+"))
	
end ping_amazon

on replace_chars(txt, srch, repl)
	set AppleScript's text item delimiters to the srch
	set the item_list to every text item of txt
	set AppleScript's text item delimiters to the repl
	set txt to the item_list as string
	set AppleScript's text item delimiters to ""
	return txt
end replace_chars

on list_to_text(theList, delim)
	set saveD to AppleScript's text item delimiters
	try
		set AppleScript's text item delimiters to {delim}
		set txt to theList as text
	on error errStr number errNum
		set AppleScript's text item delimiters to saveD
		error errStr number errNum
	end try
	set AppleScript's text item delimiters to saveD
	return (txt)
end list_to_text
