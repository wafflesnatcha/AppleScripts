try
	tell application "Safari" to set _url to URL of first document
	tell application "Google Chrome Canary"
		activate
		open location _url
	end tell
on error error_message number error_number
	display alert "Error" message error_message as warning buttons {"OK"} default button 1
end try