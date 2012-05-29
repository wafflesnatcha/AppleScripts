(*
-- Toggle "Hide extension" of the selected files in Finder
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

tell application "Finder"
	set _files to selection as alias list
	select _files
	repeat with f in _files
		set extension hidden of f to (not extension hidden of f)
	end repeat
end tell