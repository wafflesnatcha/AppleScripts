#!/usr/bin/env osascript
(*
-- Resizes selected images in Finder
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

property _size : ""

on run argv
	tell application "Finder"
		if class of argv is list and (count of argv) > 0 then
			if class of item 1 of argv is list then
				-- Run from Automator action
				set _files to item 1 of argv as alias list
			else
				-- Run from command line
				set _files to argv as list
			end if
		else
			set _files to selection as alias list
		end if
	end tell
	if (count of _files) is less than 1 then tell application "Finder" to set _files to choose file with multiple selections allowed
	if my getSize() is false then return
	repeat with I in _files
		my resize(I)
	end repeat
end run

on resize(f)
	try
		tell application "Finder" to set _src to (duplicate f to (container of f) with exact copy) as alias
		tell application "Image Events"
			set _image to open _src
			scale _image to size _size
			save _image in _src
			close _image
		end tell
	on error _msg number _num
		return display alert "Error" message _msg as warning
	end try
end resize

on getSize()
	display dialog "Enter the desired dimension (in pixels) of the longest side of the image:" default answer _size
	try
		set res to the text returned of the result as integer
	on error
		set res to 0
	end try
	if res ² 0 then
		display alert "Error" message "Dimension must be a number greater than 0." as warning
		return false
	end if
	set _size to res
end getSize