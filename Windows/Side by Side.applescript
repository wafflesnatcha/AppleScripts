-- An applescript that resizes the front two windows of the active application side by side, filling the screen.
-- Written by Simon Dorfman, January 4, 2006. www.SimonDorfman.com

-- Save this script to ~/Library/Scripts/Applications/Run from QuickSilver Triggers, Don't move these/Front 2 Windows Side by Side - Control + Option + C.scpt
-- I use keyboard shortcut Control + Option + C to run it.  I think of the C as standing for "Compare".
-- You'll need to have "Enable access for assisstive devices" enabled under Universal Access in System Preferences.


set menubarHeight to 22
--set screenWidth to word 3 of (do shell script "defaults read /Library/Preferences/com.apple.windowserver | grep -w Width") as number
--set screenHeight to word 3 of (do shell script "defaults read /Library/Preferences/com.apple.windowserver | grep -w Height") as number
--if you plan to use this on just one computer where the screen dimensions won't change, this script will run faster if you just hard code your screen resolution with these two lines:
set screenWidth to 1280
set screenHeight to 800
{screenWidth, screenHeight}

tell application "System Events"
	set frontApp to name of first application process whose frontmost is true
end tell

--some apps are wacky and put the windows higher for some reason, adjust for this bug.
if (frontApp is equal to "Finder" or frontApp is equal to "Microsoft Entourage") then
	set menubarHeight to 44
end if
--leave room for the Excel Toolbar
if (frontApp is equal to "Microsoft Excel") then
	set menubarHeight to 55
end if

try
	tell application frontApp
		set bounds of window 1 to {0, menubarHeight, (screenWidth / 2), screenHeight}
		set bounds of window 2 to {(screenWidth / 2), menubarHeight, screenWidth, screenHeight}
	end tell
on error the error_message number the error_number
	display dialog "Error: " & the error_number & ". " & the error_message buttons {"OK"} default button 1
end try