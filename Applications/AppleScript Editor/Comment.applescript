(*
-- Insert comments into the front AppleScript Editor Document
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

on run argv
	tell application "AppleScript Editor" to tell front document
		if ((contents of selection) as text) is not "" then
			return my blockComment()
		else
			return my lineComment()
		end if
	end tell
end run

on lineComment()
	tell application "AppleScript Editor" to tell front document
		set _index to item 1 of (character range of selection as list) as number
		set _paragraph to a reference to paragraph (count of paragraphs in ((characters 1 through _index of contents) as text)) of contents
		set _pad to ""
		set _txt to contents of _paragraph as text
		repeat until first character of _txt is not in {" ", tab}
			set _pad to _pad & character 1 of _txt
			set _txt to characters 2 through -1 of _txt as text
		end repeat
		if _txt starts with "--" then
			set contents of _paragraph to _pad & my trimLeft((characters 3 through -1 of _txt) as text, false)
		else
			set contents of _paragraph to _pad & "-- " & _txt
		end if
	end tell
end lineComment

on blockComment()
	tell application "AppleScript Editor" to tell front document
		set _ref to a reference to contents of selection
		set _txt to my trim(contents of _ref, false)
		if _txt starts with "(*" and _txt ends with "*)" then
			set contents of _ref to my trimLeft((characters 3 through -3 of _txt) as text, {linefeed, return}) as text
		else
			set contents of _ref to "(*" & linefeed & my trim(contents of _ref, {linefeed, return}) & linefeed & "*)" & linefeed
		end if
	end tell
end blockComment

on trim(_txt, _chars)
	return my trimLeft(my trimRight(_txt, _chars), _chars)
end trim

on trimLeft(_txt, _chars)
	if (class of _chars is not list or _chars is {}) then set _chars to {" ", tab, linefeed, return, ASCII character 0}
	repeat until first character of _txt is not in _chars
		set _txt to text 2 thru -1 of _txt
	end repeat
	return _txt
end trimLeft

on trimRight(_txt, _chars)
	if (class of _chars is not list or _chars is {}) then set _chars to {" ", tab, linefeed, return, ASCII character 0}
	repeat until last character of _txt is not in _chars
		set _txt to text 1 thru -2 of _txt
	end repeat
	return _txt
end trimRight