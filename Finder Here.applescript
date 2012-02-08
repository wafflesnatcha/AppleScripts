(*
-- Finder Here
-- Open a Finder window at the frontmost window's current document
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	set _files to {}
	if class of argv is list then
		set _files to argv
	else
		set _files to (frontmostFile() of _UI of lib) as list
	end if
	
	my openThese(_files)
	activate application "Finder"
end process

on openThese(_files)
	if (count of _files) < 1 then return false
	tell application "Finder"
		repeat with f in _files
			if class of f is alias then
				if kind of f is "Folder" then
					open f
				else
					select f
				end if
			end if
		end repeat
	end tell
end openThese