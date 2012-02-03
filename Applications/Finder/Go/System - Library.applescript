property Finder : load script POSIX path of (path to scripts folder) & "lib/Application/Finder.scpt"
try
	tell application "System Events" to go(path of library folder) of Finder
on error error_message number error_number
	display alert error_message as warning
end try