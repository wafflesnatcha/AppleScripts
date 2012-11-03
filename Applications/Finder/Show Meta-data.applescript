(*
-- Show Meta-data
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

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
	if (count of _files) is less than 1 then return display alert "Error" message "No files selected!" as warning giving up after 5
	tell application "Finder"
		repeat with f in _files
			try
				do shell script "mdls " & quoted form of POSIX path of (f as string) & " | open -f"
			end try
		end repeat
	end tell
end run