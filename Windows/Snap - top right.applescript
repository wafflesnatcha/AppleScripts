(*
-- Snaps the window to the edge of the screen
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"

on run argv
	tell application "System Events"
		set _window to first window of (frontmostApplicationProcess() of _UI of lib)
		set _s to desktopBounds() of _UI of lib
		set _w to elementBounds(_window) of _UI of lib
		set position of _window to {(x2 of _s) - (width of _w), y1 of _s}
	end tell
end run