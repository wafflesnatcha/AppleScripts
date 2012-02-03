(*
-- Compress with Keka
-- Takes the selected files in Finder and sends them to keka
*)

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
	
	set _pathnames to ""
	
	repeat with f in _files
		set _pathnames to _pathnames & " " & quoted form of POSIX path of (f as alias)
	end repeat
	
	if _pathnames is "" then return
	
	set _script to "open -a Keka " & _pathnames & " --args -action 2"
	do shell script _script
end process