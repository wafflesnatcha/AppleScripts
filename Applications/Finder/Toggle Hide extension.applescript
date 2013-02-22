(*
-- Toggle "Hide extension" of the selected files in Finder
--
-- @author Scott Buchanan <http://wafflesnatcha.github.com>
*)

tell application "Finder"
	set _files to selection as alias list
	if _files is {} then return display alert "Nothing selected!" as warning giving up after 5
	repeat with f in _files
		set extension hidden of f to (not extension hidden of f)
	end repeat
	set selection to _files
end tell