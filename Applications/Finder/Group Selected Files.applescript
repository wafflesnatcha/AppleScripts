(*
-- Group Selected Files
-- Move selected files in Finder into a new subdirectory
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

tell application "Finder"
	set _files to selection as alias list
	if _files is {} then return
	try
		set _new to container of first item in _files
	on error
		set _new to insertion location
	end try
	set _folder to make new folder at _new
	move _files to _folder
	set selection to _folder
end tell