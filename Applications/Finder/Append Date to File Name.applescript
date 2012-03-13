(*
-- Append Date to File Name
-- Adds the current date to the end of the selected file name (before the extension)
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"

property date_separator : "-"
property date_prefix : "-"

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
	
	if (count of _files) is less than 1 then
		tell application "System Events" to display alert "Error" message "No files selected" as warning
		return
	end if
	
	set date_stamp to getDateStamp()
	
	tell application "Finder"
		repeat with f in _files
			set _name to (name of f) as text
			set _ext to (name extension of f) as text
			if _ext is not "" then set _ext to "." & _ext
			set prefix to characters 1 thru ((length of _name) - (length of _ext)) of _name as text
			set n to uniqueFile({path:(container of f as alias), prefix:(prefix & date_prefix & date_stamp), suffix:_ext}) of _File of lib
			set name of f to n
		end repeat
	end tell
end process

on getDateStamp()
	set d to (current date)
	return Â
		(year of d) & date_separator & Â
		padLeft(month of d as integer, 0, 2) of _Text of lib & date_separator & Â
		padLeft(day of d, 0, 2) of _Text of lib
end getDateStamp

on getTimeStamp()
	set d to (current date)
	set time_stamp to Â
		padLeft(hours of d, 0, 2) of _Text of lib & Â
		padLeft(minutes of d, 0, 2) of _Text of lib & Â
		padLeft(seconds of d, 0, 2) of _Text of lib
end getTimeStamp