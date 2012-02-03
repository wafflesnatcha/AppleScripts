(*
-- Quit Processes.scpt
-- Select from a list of running processes to quit
*)

property lib : load script (POSIX path of (path to scripts folder) & "lib/lib.scpt")
property last_processes : missing value

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	set _processes to my chooseProcess()
	if _processes is false then return
	repeat with p in _processes
		tell application "System Events" to tell application process p
			set _id to bundle identifier
			set _pid to unix id as text
		end tell
		if application id _id is running then
			try
				with timeout of 2 seconds
					tell application id _id to quit
				end timeout
			on error
				do shell script "kill " & quoted form of _pid
			end try
		end if
	end repeat
end process

on chooseProcess()
	tell application "System Events" to get displayed name of every application process
	set _processes to bubbleSort(result) of _List of lib
	
	choose from list _processes with title "Quit Process" default items last_processes with multiple selections allowed
	if result is not false then
		set last_processes to result
		return last_processes
	end if
	return false
end chooseProcess