(*
-- Frontmost Application
-- View the properties of the frontmost application process
--
-- @author Scott Buchanan <http://wafflesnatcha.github.com>
*)

property _properties : {Â
	"accepts high level events", Â
	"accepts remote events", Â
	"accessibility description", Â
	"application file", Â
	"architecture", Â
	"background only", Â
	"bundle identifier", Â
	"class", Â
	"Classic", Â
	"creator type", Â
	"description", Â
	"displayed name", Â
	"enabled", Â
	"entire contents", Â
	"file", Â
	"file type", Â
	"focused", Â
	"frontmost", Â
	"has scripting terminology", Â
	"help", Â
	"id", Â
	"maximum value", Â
	"minimum value", Â
	"name", Â
	"orientation", Â
	"partition space used", Â
	"position", Â
	"role", Â
	"role description", Â
	"selected", Â
	"short name", Â
	"size", Â
	"subrole", Â
	"title", Â
	"total partition size", Â
	"unix id", Â
	"value", Â
	"visible"}

on run argv
	do shell script "echo " & quoted form of probeApplicationProcess() & " | open -f"
end run

on probeApplicationProcess()
	set _pad_length to 0
	repeat with _item in every item of _properties
		if (count of _item) > _pad_length then set _pad_length to (count of _item)
	end repeat
	
	set output to ""
	tell application "System Events"
		set p to properties of first application process whose frontmost is true
		
		set l to {accepts high level events of p, accepts remote events of p, accessibility description of p, application file of p, architecture of p, background only of p, bundle identifier of p, class of p, Classic of p, creator type of p, description of p, displayed name of p, enabled of p, entire contents of p, file of p, file type of p, focused of p, frontmost of p, has scripting terminology of p, help of p, id of p, maximum value of p, minimum value of p, name of p, orientation of p, partition space used of p, position of p, role of p, role description of p, selected of p, short name of p, size of p, subrole of p, title of p, total partition size of p, unix id of p, value of p, visible of p}
		
		repeat with i from 1 to the (count of _properties)
			set _key to item i of _properties
			set _val to item i of l
			set _class to class of _val as text
			
			set _line to my padRight(_key, " ", _pad_length) & " : "
			
			if _val is missing value or _class is "boolean" or _class is "integer" or _class is "class" then
				set _line to _line & (_val as string)
			else if _class is "list" then
				set _line to _line & "{" & (_val as string) & "}"
			else if _class is "text" then
				set _line to _line & "\"" & (_val as string) & "\""
			else
				set _line to _line & _class & " \"" & (_val as string) & "\""
			end if
			
			set output to output & _line & linefeed
		end repeat
	end tell
	return output
end probeApplicationProcess

on padRight(_txt, _character, _length)
	set _txt to (_txt as text)
	set _character to (_character as text)
	set i to (_length - (length of _txt))
	repeat i times
		set _txt to _txt & _character
	end repeat
	return _txt
end padRight