(*
-- Crush Images
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script (POSIX path of (path to scripts folder) & "lib/lib.scpt")

property _crush_bin : missing value
property _cocoadialog_bin : missing value

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
	
	if _crush_bin is missing value then
		set _crush_bin to my findBin("crush.sh") of _File of lib
		if result is missing value then
			display alert "Error" message "crush.sh not found" as warning buttons {"OK"} default button 1
			return false
		end if
	end if
	
	set _paths to my toShellArg(_files) of _File of lib
	if result is false then return false
	
	set _script to "cd \"$TMPDIR\";" & (quoted form of _crush_bin) & " -p " & _paths
	
	if _cocoadialog_bin is missing value then set _cocoadialog_bin to findBin("CocoaDialog") of _File of lib
	if _cocoadialog_bin is not missing value then set _script to _script & "  | " & (quoted form of _cocoadialog_bin) & " progressbar --title 'pngcrush'"
	bashScript(_script, true) of lib
end process