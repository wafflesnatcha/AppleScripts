(*
-- Prowl URL
-- Send the current Firefox URL to prowl (via prowlnotify)
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"
property Firefox : include("Application/Firefox") of lib

on run argv
	set _url to getURL() of Firefox
	if _url is not false then
		do shell script "bash -lc \"prowlnotify -a Firefox --url " & quoted form of _url & " \""
	end if
end run