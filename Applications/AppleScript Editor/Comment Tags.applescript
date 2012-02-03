property CR : ASCII character 13
property NL : ASCII character 10

on run argv
	tell application "AppleScript Editor"
		tell front document
			set _text to (contents of selection) as text
			
			if _text is not "" then return my multiLine(a reference to contents of selection)
			
		end tell
	end tell
end run

on singleLine()
	set _output to ""
	get _text
	return _text
end singleLine


on multiLine(_ref)
	set _text to contents of _ref
	tell application "AppleScript Editor"
		--tell front document
		if the _text contains "(*" and the _text contains "*)" then
			set BlockStart to the _text starts with "(*" & CR or the _text starts with "(*" & NL
			set BlockEnd to the _text ends with "*)" & CR or the _text ends with "*)" & NL
			if BlockStart and BlockEnd then
				--Case as normally created by this script
				set contents of _ref to characters 4 through -4 of _text as text
			else
				set BlockStart to the _text starts with "(*"
				set BlockEnd to the _text ends with "*)"
				if BlockStart and BlockEnd then
					--Block starts with "(*" exactly and ends with "*)" exactly
					set contents of _ref to characters 3 through -3 of _text as text
				else
					--find first occurrence of "(*"
					set BlockStartOffset to offset of "(*" in _text
					--find last occurrence of "*)"
					set SelectionLength to length of _text
					set BlockEndOffset to SelectionLength - Â
						(offset of ")*" in (reverse of (characters of _text) as text))
					log {BlockStartOffset, BlockEndOffset, SelectionLength}
					
					if BlockStartOffset is less than BlockEndOffset then
						if BlockStart then
							--Block starts with "(*", but "*)" is somewhere before end of selection
							set Newtext to (characters 3 through (BlockEndOffset - 1) of _text as text) & Â
								characters (BlockEndOffset + 2) through -1 of _text as text
							set contents of _ref to Newtext
						else
							if BlockEnd then
								--Block ends with "*)", but "(*" is somewhere past beginning of selection
								set Newtext to (characters 1 through (BlockStartOffset - 1) of _text as text) & Â
									characters (BlockStartOffset + 2) through -3 of _text as text
								set contents of _ref to Newtext
							else
								--Block start and end are not at the selection end points (extract three blocks of text)
								set Newtext to ((characters 1 through (BlockStartOffset - 1) of _text as text) & Â
									characters (BlockStartOffset + 2) through (BlockEndOffset - 1) of _text as text) & Â
									characters (BlockEndOffset + 2) through -1 of _text as text
								set contents of _ref to Newtext
							end if
						end if
					else
						--Must be a request to add comment block
						if the last character of _text is in {CR, NL} then
							set contents of _ref to "(*" & return & Â
								_text & Â
								"*)" & return
						else
							set contents of _ref to return & Â
								"(*" & return & Â
								_text & return & Â
								"*)" & return
						end if
					end if
				end if
			end if
		else
			--Must be a request to add comment block
			if the last character of _text is in {CR, NL} then
				set contents of _ref to "(*" & return & _text & "*)" & return
			else
				set contents of _ref to return & "(*" & return & _text & return & "*)" & return
			end if
		end if
		--end tell
	end tell
end multiLine