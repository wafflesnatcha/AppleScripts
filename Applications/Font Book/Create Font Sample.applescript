-- "SimpleText has the same bundle signature as "TextEdit", so TextEdit is specified with a full path.

tell application "Font Book"
	
	tell application "System Events"
		set wasTextEditRunning to (name of processes) contains "TextEdit"
	end tell
	
	--	tell application TextEditApp to activate
	
	set selectedFamilies to selected font families
	set selectedTypefaces to selection
	
	set numFamilies to count selectedFamilies
	set numFaces to count selectedTypefaces
	
	tell application "TextEdit"
		if wasTextEditRunning then
			make new document at the end of documents of it
		end if
		tell the front document
			set paragraph 1 to "Font Samples - " & Â
				numFamilies & " families   " & Â
				numFaces & " typefaces" & return & return & return
			set size to 18
		end tell
	end tell
	
	--	asuuming that items in selection are sorted in font family.
	
	set paraIndex to 3
	
	repeat while selectedTypefaces is not {}
		set thisFace to first item of selectedTypefaces
		set familyName to family name of thisFace
		set selectedTypefaces to the rest of selectedTypefaces
		set postScriptNames to {PostScript name of thisFace}
		
		repeat while selectedTypefaces is not {}
			set anotherFace to first item of selectedTypefaces
			if family name of anotherFace is familyName then
				set the end of postScriptNames to PostScript name of anotherFace
				set selectedTypefaces to the rest of selectedTypefaces
			else
				exit repeat
			end if
		end repeat
		
		tell the front document of application "TextEdit"
			tell paragraph paraIndex
				set font to "LucidaGrande"
				set size to 14
				set characters to familyName & return & return
			end tell
			set paraIndex to paraIndex + 1
			
			repeat with psName in postScriptNames
				set success to true
				try
					tell paragraph paraIndex
						set font to psName
						set size to 12
						set characters to tab & psName & return & return
					end tell
				on error
					set success to false
				end try
				if success then
					set paraIndex to paraIndex + 1
				end if
			end repeat
			set paragraph paraIndex to return & return
			set paraIndex to paraIndex + 1
		end tell
		
	end repeat
	tell application "TextEdit" to activate
end tell