-- © Copyright 2005, Red Sweater Software. All Rights Reserved.
-- Permission to copy granted for personal use only. All copies of this script
-- must retain this copyright information and all lines of comments below, up to
-- and including the line indicating "End of Red Sweater Comments". 
--
-- Any commercial distribution of this code must be licensed from the Copyright
-- owner, Red Sweater Software.
--
-- This script facilitates the easy opening of a diff-comparison tool for comparing 
-- two selected items in the Finder. The items may be in the same window or 
-- split between the two frontmost windows.
--
-- Requirements: This script depends on files that are installed as part 
-- of the Xcode Development tools from Apple.
--
-- Version 1.0 - Initial release.
--
-- End of Red Sweater Comments

-- CUSTOMIZATION NOTE: Uncomment one and leave the other commented depending on your preferred diff-viewer.
-- Use this for BBEdit
-- set kFileComparisonLauncherTool to "/System/Library/PrivateFrameworks/DevToolsCore.framework/Resources/comparefiles"
-- Use this for FileMerge
set kFileComparisonLauncherTool to "/usr/bin/opendiff"

tell application "Finder"
	-- Have to explicitly activate the Finder because some script clients,
	-- such as the Apple Script Menu, annoyingly become frontmost when running
	-- the script. We rely on the Finder being frontmost in order to get the 
	-- window switching behavior to change the selection and let us know what's 
	-- selected in the secondary window.
	activate
	
	-- If there are exactly two files in the frontmost selection,
	-- we'll compare them.
	set file1 to ""
	set file2 to ""
	if (count of (selection as list)) is equal to 2 then
		set {file1, file2} to (selection as list)
	else
		if (count of (selection as list)) is equal to 1 then
			try
				set file1 to item 1 of (selection as list)
			on error
				set file1 to ""
			end try
		end if
		
		-- Switch to second window		
		set index of window 2 to 1
		if (count of (selection as list)) is equal to 1 then
			try
				set file2 to item 1 of (selection as list)
			on error
				set file2 to ""
			end try
		end if
		
		-- Switch back
		set index of window 2 to 1
	end if
	
	if (file1 is equal to "") or (file2 is equal to "") then
		display dialog "Please select exactly two files before running this script. The files may be in the front window or split across the two frontmost windows."
	else
		set path1 to POSIX path of (file1 as alias)
		set path2 to POSIX path of (file2 as alias)
		my CompareTwoFiles(kFileComparisonLauncherTool, path1, path2)
	end if
end tell

on CompareTwoFiles(comparisonTool, path1, path2)
	set myScriptText to comparisonTool & " " & quoted form of path1 & " " & quoted form of path2 & " &>/dev/null&"
	do shell script myScriptText
end CompareTwoFiles