(*
-- Move the selected files in Finder into a new subdirectory
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
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
	select _folder
end tell