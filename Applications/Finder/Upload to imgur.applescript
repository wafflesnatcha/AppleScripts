(*
-- Upload to imgur
-- Upload the selected Finder items to imgur
--
-- Supports APNG, BMP, GIF, JPEG, PDF, PNG, TIFF, XCF
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"

property _formats : {"APNG", "BMP", "GIF", "JPG", "JPEG", "PDF", "PNG", "TIFF", "XCF"}
property _cocoadialog_bin : missing value

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	if (class of argv) is list and (count of argv) is greater than 0 then
		set _files to argv
	else
		tell application "Finder" to set _files to selection as alias list
	end if
	
	if (count of _files) is less than 1 then set _files to choose file of type _formats with prompt "Select an image to upload"
	
	tell application "Finder"
		set f to (first item of _files)
		indexOf(_formats, (name extension of f) as text) of _List of lib
		if result < 0 then return displayError("invalid format", false) of lib
		set _path to quoted form of (POSIX path of f)
	end tell
	
	
	set _script to "{ url=$(cat " & _path & " | curl -qsSL --connect-timeout 15 -F \"image=@-\" -F \"key=1913b4ac473c692372d108209958fd15\" http://api.imgur.com/2/upload.xml | grep -Eo \"<original>(.)*</original>\" | grep -Eo \"http://i.imgur.com/[^<]*\";) && echo -n \"$url\" | pbcopy && open \"$url\" && echo \"$url\"; }"
	
	if _cocoadialog_bin is missing value then set _cocoadialog_bin to findBin("CocoaDialog") of _File of lib
	if _cocoadialog_bin is not missing value then set _script to _script & "  | " & (quoted form of _cocoadialog_bin) & " progressbar --title 'Uploading to imgur' --text " & _path & " --indeterminate"
	
	try
		bashScript(_script, true) of lib
	on error error_message number error_number
		displayError(error_message, error_number) of lib
	end try
	
end process
