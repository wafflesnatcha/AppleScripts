(*
-- Reset Window
-- Restore custom layout settings of finder windows
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)

property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"
property _Finder : include("Application/Finder") of lib

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
		
		set _settings to {current view:missing value Â
			, sidebar width:136 Â
			, statusbar visible:true Â
			, toolbar visible:true Â
			, zoomed:true Â
			, list view options:{calculates folder sizes:false Â
			, icon size:small Â
			, shows icon preview:true Â
			, text size:11 Â
			, uses relative dates:true Â
			} Â
			, column view options:{discloses preview pane:true Â
			, shows icon:true Â
			, shows icon preview:true Â
			, shows preview column:true Â
			, text size:11 Â
			} Â
			, icon view options:{arrangement:arranged by name Â
			, icon size:72 Â
			, label position:bottom Â
			, shows item info:false Â
			, shows icon preview:true Â
			, text size:11 Â
			} Â
			}
		
		if (sidebar width of _win as number) < 1 then set (sidebar width of _settings) to missing value
		if (toolbar visible of _win) = false then set (toolbar visible of _settings) to missing value
		
		setProperties(_win, _settings) of _window of _Finder
	end tell
end process