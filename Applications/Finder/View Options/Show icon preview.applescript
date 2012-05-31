(*
-- Toggle the "Show icon preview" setting of the current Finder window.
-- Applies only to the current view mode (as icons, list, columns, or cover flow)
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

tell application "Finder"
	if (current view of front Finder window) is icon view then
		set (shows icon preview of icon view options of front Finder window) to (not shows icon preview of icon view options of front Finder window)
	else if (current view of front Finder window) is list view or (current view of front Finder window) is flow view then
		set (shows icon preview of list view options of front Finder window) to (not shows icon preview of list view options of front Finder window)
	else if (current view of front Finder window) is column view then
		set (shows icon preview of column view options of front Finder window) to (not shows icon preview of column view options of front Finder window)
		if (shows icon preview of column view options of front Finder window) then set (shows icon of column view options of front Finder window) to true
	end if
end tell