(*
-- Edit with TextMate
-- Open the selected Finder items in TextMate
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property mate : "Contents/Resources/mate"

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
	
	-- In order to make sure we open files for EDITING in TextMate, we need to run mate (instead of doing just "open -a TextMate ...")
	
	set _app to POSIX path of (path to application "TextMate") as string
	do shell script (quoted form of (_app & mate)) & _pathnames
end process
