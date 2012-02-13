(*
-- Frontmost Application
-- View the properties of the frontmost application process
--
-- @author Scott Buchanan <buchanan.sc@gmail.com>
*)
property lib : load script (POSIX path of (path to scripts folder) & "lib/lib.scpt")

property application_process_properties : {"accepts high level events", "accepts remote events", "accessibility description", "application file", "architecture", "background only", "bundle identifier", "class", "Classic", "creator type", "description", "displayed name", "enabled", "entire contents", "file type", "file", "focused", "frontmost", "has scripting terminology", "help", "id", "maximum value", "minimum value", "name", "orientation", "partition space used", "position", "role description", "role", "selected", "short name", "size", "subrole", "title", "total partition size", "unix id", "value", "visible"}

on run argv
	my process(argv)
end run

on process(argv)
	set _process to frontmostApplicationProcess() of _UI of lib
	set output to probeApplicationProcess(_process)
	my outputTextEdit(output)
end process

on outputTextEdit(_content)
	if application "TextEdit" is running then tell application "TextEdit" to make new document at the end of documents of it
	tell application "TextEdit"
		set text of front document to _content
		activate
	end tell
end outputTextEdit

on probeApplicationProcess(_process)
	set output to ""
	tell application "System Events"
		set _process to first application process whose frontmost is true
		set p to properties of _process
		
		set l to {accepts high level events of p, accepts remote events of p, accessibility description of p, application file of p, architecture of p, background only of p, bundle identifier of p, class of p, Classic of p, creator type of p, description of p, displayed name of p, enabled of p, entire contents of p, file type of p, file of p, focused of p, frontmost of p, has scripting terminology of p, help of p, id of p, maximum value of p, minimum value of p, name of p, orientation of p, partition space used of p, position of p, role description of p, role of p, selected of p, short name of p, size of p, subrole of p, title of p, total partition size of p, unix id of p, value of p, visible of p}
		
		repeat with i from 1 to the (count of application_process_properties)
			set output to output & (item i of application_process_properties) & ": " & (item i of l) & "\n"
		end repeat
	end tell
	return output
end probeApplicationProcess