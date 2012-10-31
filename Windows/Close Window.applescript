(*
-- Close the first window of the frontmost application
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
-- @link http://wafflesnatcha.github.com
*)

try
	tell application (path to frontmost application as Unicode text) to close first window
end try