(*
-- Send the selected files in Finder to Keka (for compression)
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

tell application "Finder"
	set _files to selection as alias list
	if _files is {} then return display alert "Nothing selected!" as warning giving up after 5
	set _pathnames to ""
	repeat with f in _files
		set _pathnames to _pathnames & " " & quoted form of POSIX path of (f as alias)
	end repeat
	do shell script "open -b 'com.aone.keka' " & _pathnames & " --args -action 2 &>/dev/null &"
end tell