-- Convert To Mp3 - converts selected iTunes tracks to MP3 format without 
-- altering you preferred encoder preference.
--
-- by Daniel Jalkut, http://www.red-sweater.com/
-- Version 1.0

tell application "iTunes"
	set savedEncoder to current encoder
	set aacEncoder to first encoder whose name is "AAC Encoder"
	set mp3Encoder to first encoder whose name is "MP3 Encoder"
	
	set current encoder to mp3Encoder
	convert selection
	
	set current encoder to savedEncoder
end tell