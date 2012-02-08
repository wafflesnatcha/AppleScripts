(*
-- Terminal Here
-- Open Terminal at the path of the frontmost finder window
--
-- For TotalTerminal (http://totalterminal.binaryage.com) support,
-- "Show on Reopen" must be checked in the TotalTerminal Preferences.
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"
property Terminal : include("Application/Terminal") of lib

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	if (class of argv) is list and (count of argv) is greater than 0 then
		set p to item 1 of argv
	else
		set p to frontmostDirectory() of _UI of lib
	end if
	tell Terminal to newTabAt(p)
end process