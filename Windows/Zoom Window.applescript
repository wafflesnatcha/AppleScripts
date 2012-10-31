(*
-- Zoom the first window of the frontmost application
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

try
	tell application (path to frontmost application as Unicode text) to tell first window to set zoomed to not zoomed
end try