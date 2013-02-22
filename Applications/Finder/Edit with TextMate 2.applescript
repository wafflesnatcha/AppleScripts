(*
-- Open the selected Finder items in TextMate
--
-- @author Scott Buchanan <http://wafflesnatcha.github.com>
*)

property _app_id : "com.macromates.TextMate.Preview"
property _app_path : missing value
property _mate_path : "/Contents/Resources/mate"
property _mate_args : "-r"

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
		set _pathnames to _pathnames & " " & quoted form of POSIX path of (f as alias)
	end repeat
	if _pathnames is "" then return display alert "No valid files selected" as warning
	
	-- Find TextMate
	if _app_path is missing value then set _app_path to POSIX path of (path to application id _app_id) as string
	if _app_path is missing value then return display alert "Application not found!" as warning
	
	do shell script quoted form of (_app_path & "/" & _mate_path) & "  " & quoted form of _mate_args & " " & _pathnames
	activate application id _app_id
end run
