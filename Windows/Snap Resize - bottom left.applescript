(*
-- Snaps the window to the edge of the screen
-- then resizes it to 50% of the screen' width and height
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"

-- The width & height of the resulting window as a percentage of the available screen
property _size : {width:0.5, height:0.5}

on run argv
	set _app to frontmostApplication() of _UI of lib
	tell _app
		set _window to first window
		set _s to desktopBounds() of _UI of lib
		set bounds of _window to {x1 of _s, (y2 of _s) - (round (height of _s) * (height of _size)), (x1 of _s) + (round (width of _s) * (width of _size)), y2 of _s}
	end tell
	
	(*
	-- Alternative method
	tell application "System Events"
		set _process to first application process whose frontmost is true
		tell _process to set _window to first window
		set _s to desktopBounds() of _UI of lib
		log _s
		tell _process
			set position of _window to {x1 of _s, (y2 of _s) - (round (height of _s) * (height of _size))}
			set size of _window to {(round (width of _s) * (width of _size)), (round (height of _s) * (height of _size))}
		end tell
	end tell
*)
end run