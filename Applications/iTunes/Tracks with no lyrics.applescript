tell application "iTunes"
	set s to selection as list
	set n to {}
	repeat with f in s
		if lyrics of f is "" then set n to n & {location of f}
	end repeat
	if n is {} then return n
	set p to make new playlist
	set name of p to "NO LYRICS"
	add n to p
	return p
end tell