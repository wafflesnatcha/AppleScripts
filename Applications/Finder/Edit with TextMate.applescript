(*
-- Edit with TextMate
-- Open the selected Finder items in TextMate
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"

property _app_path : missing value
property _mate : "/Contents/Resources/mate"
property _args : "-r"

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	if class of argv is list then
		set _files to argv
	else
		tell application "Finder" to set _files to selection as alias list
	end if
	if (count of _files) is less than 1 then return
	
	set _pathnames to ""
	repeat with f in _files
		set _pathnames to _pathnames & " " & quoted form of POSIX path of (f as alias)
	end repeat
	if _pathnames is "" then return
	
	if _app_path is missing value then set _app_path to pathToID("com.macromates.textmate") of _Application of lib
	if _app_path is not missing value then do shell script (quoted form of (_app_path & _mate)) & "  " & _args & " " & _pathnames
end process
