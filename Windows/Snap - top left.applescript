(*
-- Snaps the window to the edge of the screen
*)

property lib : load script (POSIX path of (path to scripts folder) & "lib/lib.scpt")

on run argv
	tell application "System Events"
		set _window to first window of (frontmostApplicationProcess() of _UI of lib)
		set _s to desktopBounds() of _UI of lib
		set position of _window to {x1 of _s, y1 of _s}
	end tell
end run