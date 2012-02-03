tell application "Finder"
	try
		set p to a reference to (shows icon preview of list view options of front Finder window)
	on error
		return false
	end try
	if (contents of p) then
		set (contents of p) to false
	else
		set (contents of p) to true
	end if
end tell