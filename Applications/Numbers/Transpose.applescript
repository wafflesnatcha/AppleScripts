property paralist : {}
property liste1 : {}
property liste2 : {}
property mynewrow : {}

try
	set txtDatas to the clipboard
	set my paralist to every paragraph of txtDatas
	set srcNbRows to count of my paralist
	if txtDatas contains tab then
		my nettoie()
		repeat with p in my paralist
			set AppleScript's text item delimiters to tab
			set l to every text item of (p as text)
			set AppleScript's text item delimiters to ""
			copy l to end of my liste1
		end repeat
		set srcNbCols to count of l
		repeat with i from 1 to srcNbCols
			set newRow to {}
			repeat with j from 1 to srcNbRows
				copy item i of item j of my liste1 to end of newRow
			end repeat
			copy my transpose1(newRow) to end of my liste2
		end repeat
		set AppleScript's text item delimiters to return
		set txtDatas to my liste2 as text
		my nettoie()
	else
		set txtDatas to my transpose1(paralist)
	end if
	set the clipboard to txtDatas
	set my paralist to {}
on error
	my nettoie()
	set my paralist to {}
end try

on transpose1(l)
	set AppleScript's text item delimiters to tab
	set t to l as text
	set AppleScript's text item delimiters to ""
	return t
end transpose1

on nettoie()
	set AppleScript's text item delimiters to ""
	set my liste1 to {}
	set my liste2 to {}
	set mynewrow to {}
end nettoie