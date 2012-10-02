property _app : application id "com.artissoftware.xScope"
if _app is not running then
	run _app
	return 0
else
	tell _app to if frontmost then
		quit
		return 1
	else
		activate
		return 2
	end if
end if
