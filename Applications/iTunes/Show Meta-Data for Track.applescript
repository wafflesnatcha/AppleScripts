(*
"Show Meta-Data for Track" for iTunes
written by Doug Adams
dougadams@mac.com

v1.0 sept 4, 2007
-- initial release

Get more free AppleScripts and info on writing your own
at Doug's AppleScripts for iTunes
http://www.dougscripts.com/itunes/

This program is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

Get a copy of the GNU General Public License by writing to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

or visit http://www.gnu.org/copyleft/gpl.html

*)


tell application "iTunes"
	set sel to selection
	if sel is not {} and length of sel is 1 then
		my show_metadata(location of item 1 of sel)
	else
		display dialog "Select a single track..." buttons {"Cancel"} default button 1 with icon 2 giving up after 15
		
	end if
end tell

to show_metadata(loc)
	do shell script "mdls " & quoted form of POSIX path of (loc as string) & " | open -f"
end show_metadata