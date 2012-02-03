(*
-- Snaps the window to the edge of the screen
-- then resizes it to 50% of the screen' width and height
*)

property lib : load script (POSIX path of (path to scripts folder) & "lib/lib.scpt")

-- The width & height of the resulting window as a percentage of the available screen
property _size : {width:0.5, height:0.5}

on run argv
	set _app to frontmostApplication() of _UI of lib
	tell _app
		set _window to first window
		set _s to desktopBounds() of _UI of lib
		set bounds of _window to {(x2 of _s) - (round (width of _s) * (width of _size)), (y2 of _s) - (round (height of _s) * (height of _size)), x2 of _s, y2 of _s}
	end tell
end run