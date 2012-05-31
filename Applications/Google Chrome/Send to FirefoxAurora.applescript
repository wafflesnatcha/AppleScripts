try
	using terms from application "Google Chrome"
		tell application (path to frontmost application as Unicode text) to set _url to URL of active tab of first window
	end using terms from
	do shell script "open -b org.mozilla.aurora " & quoted form of _url
on error error_message number error_number
	display alert "Error" message error_message as warning buttons {"OK"} default button 1
end try