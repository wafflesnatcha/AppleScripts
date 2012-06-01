tell application "System Events" to try
	set _path to (path of sites folder) as string
on error
	return
end try
tell application "Finder"
	activate
	try
		tell the front Finder window to if toolbar visible then
			set target to _path
		else
			open _path
		end if
	on error
		open _path
	end try
end tell