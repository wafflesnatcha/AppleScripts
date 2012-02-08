(*
-- Reset Window
-- Restore custom layout settings of finder windows
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"
property _Finder : include("Application/Finder") of lib

using terms from application "Finder"
	property _settings : {current view:missing value Â
		, zoomed:true Â
		, sidebar width:136 Â
		, statusbar visible:true Â
		, toolbar visible:true Â
		, list view options:{calculates folder sizes:false, icon size:small, text size:11, uses relative dates:true} Â
		, column view options:{text size:11, shows icon:true, shows icon preview:true, shows preview column:true, discloses preview pane:true} Â
		, icon view options:{arrangement:arranged by name, icon size:72, shows item info:false, shows icon preview:true, text size:11, label position:bottom} Â
		}
	
end using terms from

on run argv
	my process(argv)
end run

on open argv
	my process(argv)
end open

on process(argv)
	tell application "Finder"
		try
			set _win to the front Finder window
		on error
			return false
		end try
		
		setProperties(_win, _settings) of _window of _Finder
	end tell
end process