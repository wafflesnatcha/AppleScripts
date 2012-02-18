(*
-- Convert Image Format
-- Convert selected images in Finder between various image formats
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"

property script_name : missing value
property _formats : {"BMP", "GIF", "ICNS", "ICO", "JPEG", "JPEG2", "PDF", "PICT", "PNG", "PSD", "TGA", "TIFF"}
property _formats_ext : {".bmp", ".gif", ".icns", ".ico", ".jpg", ".jp2", ".pdf", ".pict", ".png", ".psd", ".tga", ".tif"}
property _last_format : missing value
property _last_quality : 60

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	if script_name is missing value then set script_name to scriptName() of _File of lib
	
	if (class of argv) is list and (count of argv) is greater than 0 then
		set _files to argv
	else
		tell application "Finder" to set _files to selection as alias list
	end if
	
	if (count of _files) is less than 1 then set _files to choose file with multiple selections allowed
	if (count of _files) is less than 1 then return
	
	if not my getImageFormat() then return
	
	set i to 1
	repeat with f in _formats
		if f as string = _last_format as string then
			set _new_ext to item i of _formats_ext
			exit repeat
		end if
		set i to i + 1
	end repeat
	
	tell application "Finder"
		repeat with f in _files
			set theItem to f as alias
			set _name to name of (f as alias)
			set _ext to name extension of (f as alias)
			
			if length of _ext > 0 then set _name to text 1 thru ((length of _name) - (length of _ext) - 1) of _name as text
			
			set _path to POSIX path of (container of f as alias)
			
			set _dest to _path & uniqueFile({path:_path, prefix:_name, suffix:_new_ext}) of _File of lib
			
			if my convertImage(f as alias, _dest, _last_format) then select ((_dest as string) as POSIX file)
		end repeat
	end tell
end process

on getImageFormat()
	tell current application
		set f to choose from list _formats with title script_name with prompt "Select an Image Format:" default items _last_format
		if f is false then return false
		set _last_format to item 1 of f
	end tell
	return true
end getImageFormat

on convertImage(_src, _dest, f)
	if f is "ICNS" then
		return my makeicns(_src, _dest)
	else
		return my ImageMagick(_src, _dest, f)
	end if
end convertImage

on getImageSize(_src)
	try
		tell application "Image Events"
			set _image to open _src
			get dimensions of _image
			set _d to {width:item 1 of result, height:item 2 of result}
			close _image
			return _d
		end tell
	on error
		return false
	end try
end getImageSize

on makeicns(_src, _dest)
	set _in to quoted form of POSIX path of (_src as alias)
	set _out to quoted form of _dest
	
	set _params to "-in " & _in
	
	set _size to my getImageSize(_src)
	
	-- Only create icon size variants if the source image is large enough
	if class of _size is not boolean then
		set _params to "-16 " & _in
		set _s to width of _size
		if height of _size > _s then set _s to height of _size
		if _s > 16 then set _params to _params & " -32 " & _in
		if _s > 32 then set _params to _params & " -128 " & _in
		if _s > 128 then set _params to _params & " -256 " & _in
		if _s > 256 then set _params to _params & " -512 " & _in
	end if
	
	try
		do shell script "bash -lc \"makeicns " & _params & " -out " & _out & "\""
	on error error_message number error_number
		displayError(error_message, error_number) of lib
		return false
	end try
	return true
end makeicns

on ImageMagick(_src, _dest, f)
	set _in to quoted form of POSIX path of (_src as alias)
	set _out to quoted form of _dest
	set _opts to ""
	
	if f = "JPEG" and not (my getQuality() as string = "false") then
		set _opts to _opts & " -quality " & result
	else
		return false
	end if
	if f = "PNG" then set _opts to _opts & " -background transparent"
	
	set _cmd to "bash -lc \"convert " & _in & " " & _opts & " " & _out & "\""
	try
		do shell script _cmd
	on error error_message number error_number
		displayError(error_message, error_number) of lib
		return false
	end try
	return true
end ImageMagick

on getQuality()
	display dialog "Compression Quality (1-100):" default answer _last_quality
	set res to the text returned of the result as integer
	if res < 1 or res > 100 then
		displayError("Compression quality must be a number from 1 to 100.", null) of lib
		return false
	end if
	set _last_quality to res
	return _last_quality
end getQuality