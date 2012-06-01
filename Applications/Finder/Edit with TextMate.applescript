(*
-- Open the selected Finder items in TextMate
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

property _app_path : missing value
property _mate : "/Contents/Resources/mate"
property _args : "-r"

on run
	tell application "Finder" to set _files to selection as alias list
	if _files is {} then return display alert "Nothing selected!" as warning giving up after 5
	
	set _pathnames to ""
	repeat with f in _files
		set _pathnames to _pathnames & " " & quoted form of POSIX path of (f as alias)
	end repeat
	if _pathnames is "" then return display alert "No valid files selected" as warning
	
	-- Find TextMate
	if _app_path is missing value then set _app_path to POSIX path of (path to application id "com.macromates.textmate") as string
	if _app_path is missing value then return display alert "TextMate application not found" as warning
	
	do shell script (quoted form of (_app_path & _mate)) & "  " & _args & " " & _pathnames
	activate application id "com.macromates.textmate"
end run
