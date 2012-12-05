(*
-- Change the display of the front most Finder window to your own preconfigured settings.
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

property E : missing value

using terms from application "Finder"
	property _settings : {current view:E, width:620, height:390, sidebar width:E, statusbar visible:true, toolbar visible:true, zoomed:E Â
		, list view options:{calculates folder sizes:false, icon size:small, shows icon preview:true, text size:10, uses relative dates:true, |columns|:{{class:column, name:modification date column, index:E, sort direction:E, width:128, visible:E}}} Â
		, column view options:{discloses preview pane:true, shows icon:true, shows icon preview:true, shows preview column:true, text size:10} Â
		, icon view options:{arrangement:arranged by name, icon size:96, label position:bottom, shows item info:false, shows icon preview:true, text size:10} Â
		}
end using terms from

on run
	tell application "Finder"
		try
			set _win to the front Finder window
			select _win
		on error
			return false
		end try
		
		if (sidebar width of _win as number) < 1 then set (sidebar width of _settings) to E
		if (toolbar visible of _win) = false then set (toolbar visible of _settings) to E
		
		my setProperties(_win, _settings)
	end tell
end run

on setProperties(_win, _p)
	tell application "Finder"
		tell _win
			if statusbar visible of _p is not E then set statusbar visible to statusbar visible of _p
			if toolbar visible of _p is not E then set toolbar visible to toolbar visible of _p
			if sidebar width of _p is not E then set sidebar width to sidebar width of _p
			if current view of _p is not E then set current view to current view of _p
			
			if (list view options of _p) is not E then set properties of (list view options of _win) to list view options of _p
			if (column view options of _p) is not E then set properties of (column view options of _win) to column view options of _p
			if (icon view options of _p) is not E then set properties of (icon view options of _win) to icon view options of _p
			
			if (|columns| of list view options of _p) is not E then
				repeat with c in (|columns| of list view options of _p)
					set _col to (first column of (list view options of _win) whose name is (name of c))
					if width of c is not E then set width of _col to width of c
					if sort direction of c is not E then set sort direction of _col to sort direction of c
					if index of c is not E then set index of _col to index of c
					if visible of c is not E then set visible of _col to visible of c
				end repeat
			end if
			
			if zoomed of _p is not E then set zoomed to zoomed of _p
			try
				my resizeWindow(_win, width of _p, height of _p)
			end try
		end tell
	end tell
end setProperties

on resizeWindow(_win, _width, _height)
	if (_width is E and _height is E) then return false
	tell application "Finder"
		set _b to bounds of _win
		if class of _width is string then
			set c to first character of _width
			if c is "+" then set _width to ((item 3 of _b) - (item 1 of _b)) + (_width as integer)
			if c is "+" then
				set _width to ((item 4 of _b) - (item 2 of _b)) + (_width as integer)
			else if c is "-" then
				set _width to ((item 4 of _b) - (item 2 of _b)) - (_width as integer)
			end if
		end if
		if class of _height is string then
			set c to first character of _height
			if c is "+" then
				set _height to ((item 4 of _b) - (item 2 of _b)) + (_height as integer)
			else if c is "-" then
				set _height to ((item 4 of _b) - (item 2 of _b)) - (_height as integer)
			end if
		end if
		if _width is not E then set item 3 of _b to (item 1 of _b) + (_width as integer)
		if _height is not E then set item 4 of _b to (item 2 of _b) + (_height as integer)
		set bounds of _win to _b
	end tell
end resizeWindow