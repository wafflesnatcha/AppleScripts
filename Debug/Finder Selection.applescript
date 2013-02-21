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
	
	set _pathnames to ""
	repeat with f in _files
		set _pathnames to _pathnames & POSIX path of (f as alias) & linefeed
	end repeat
	do shell script "echo " & quoted form of _pathnames & " | open -f"
end run
