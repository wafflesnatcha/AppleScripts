(*
-- Resize Image (and duplicate)
-- Resizes selected images in Finder
*)

property _size : ""

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
		set _files to (selection of application "Finder")
	end if
	
	if (count of _files) is less than 1 then set _files to choose file with prompt "Select an image to resize" with multiple selections allowed
	
	set _size to my getSize()
	if _size is false then return
	
	repeat with i in _files
		my resize(i)
	end repeat
end process

on resize(f)
	tell application "Image Events"
		try
			set _test to open (f as alias)
			close _test
		on error error_message number error_number
			tell application "Finder" to display alert "Error" message (POSIX path of (f as string)) & " cannot be resized." as warning buttons {"OK"} default button 1
			return
		end try
		
		log f
		duplicate f
		set _src to (result as alias)
		log _src
		
		set _image to open _src
		scale _image to size _size
		save _image in _src
		close _image
	end tell
end resize

on getSize()
	display dialog "Enter the desired dimension (in pixels) of the longest side of the image:" default answer _size
	try
		set res to the text returned of the result as integer
	on error
		display alert "dimension must be greater than 1" as warning buttons {"Close"} default button 1
		return false
	end try
	if res is less than 1 then
		display alert "dimension must be greater than 1" as warning buttons {"Close"} default button 1
		return false
	end if
	return res
end getSize