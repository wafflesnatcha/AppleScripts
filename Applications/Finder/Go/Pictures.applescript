property _path : missing value
if _path is missing value then tell application "System Events" to set _path to (path of pictures folder) as string
tell application "Finder"
	activate
	try
		tell the front Finder window
			if toolbar visible then
				set target to _path
			else
				open _path
			end if
		end tell
	on error
		open _path
	end try
end tell