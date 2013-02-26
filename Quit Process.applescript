(*
-- Select from a list of running processes to quit
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

property last_processes : missing value

on run
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
end run

on chooseProcess()
	tell application "System Events" to get displayed name of every application process
	set _processes to my quickSort(result)
	
	choose from list _processes with title "Quit Process" default items last_processes with multiple selections allowed
	if result is not false then
		set last_processes to result
		return last_processes
	end if
	return false
end chooseProcess

on quickSort(_l)
	script bs
		property alist : _l
		on Qsort(leftIndex, rightIndex)
			if rightIndex > leftIndex then
				set pivot to ((rightIndex - leftIndex) div 2) + leftIndex
				set newPivot to Qpartition(leftIndex, rightIndex, pivot)
				set _l to Qsort(leftIndex, newPivot - 1)
				set _l to Qsort(newPivot + 1, rightIndex)
			end if
		end Qsort
		on Qpartition(leftIndex, rightIndex, pivot)
			set pivotValue to item pivot of bs's alist
			set temp to item pivot of bs's alist
			set item pivot of bs's alist to item rightIndex of bs's alist
			set item rightIndex of bs's alist to temp
			set tempIndex to leftIndex
			repeat with pointer from leftIndex to (rightIndex - 1)
				if item pointer of bs's alist ² pivotValue then
					set temp to item pointer of bs's alist
					set item pointer of bs's alist to item tempIndex of bs's alist
					set item tempIndex of bs's alist to temp
					set tempIndex to tempIndex + 1
				end if
			end repeat
			set temp to item rightIndex of bs's alist
			set item rightIndex of bs's alist to item tempIndex of bs's alist
			set item tempIndex of bs's alist to temp
			return tempIndex
		end Qpartition
	end script
	if length of bs's alist > 1 then bs's Qsort(1, length of bs's alist)
	return bs's alist
end quickSort
