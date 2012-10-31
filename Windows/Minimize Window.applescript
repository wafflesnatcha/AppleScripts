(*
-- Minimize the first window of the frontmost application
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

try
	tell application (path to frontmost application as text) to tell first window to set miniaturized to not miniaturized
end try