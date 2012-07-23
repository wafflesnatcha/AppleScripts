tell application id "com.apple.TextEdit"
	try
		tell front document to display dialog (count every character) & " characters" & return & (count every word) & " words" & return & (count every paragraph) & " paragraphs" as text with title "Statistics for '" & (name of it as text) & "'" buttons {"OK"} default button 1 cancel button 1
	end try
end tell
