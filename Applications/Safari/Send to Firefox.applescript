try
	tell application "Safari" to set _url to URL of first document
	do shell script "open -a Firefox " & quoted form of _url
on error error_message number error_number
	display alert "Error" message error_message as warning buttons {"OK"} default button 1
end try