#!/usr/bin/env bash

filetypes="apng|bmp|gif|jpg|jpeg|pdf|png|tiff|xcf"

ERROR() {
	[[ $1 ]] && {
		echo "${0##*/}: $1" 1>&2
		osascript -e 'tell application "System Events" to display alert "Error" message "'"$1"'" as warning buttons {"OK"} default button 1' &>/dev/null &
	}
	[[ $2 > -1 ]] && exit $2;
}

imgur() {
	local result=$(cat "$1" | curl -qL $([[ $TERM = "dumb" ]] && echo "-sS" || echo "-#") --connect-timeout 15 -F "image=@-" -F "key=1913b4ac473c692372d108209958fd15" "http://api.imgur.com/2/upload.xml")
	local url=$(echo -e "$result" | perl -ne 'print if s/.*<original>(http:\/\/i.imgur.com\/[^<]*)<\/original>.*/\1/i')
	[[ $? = 0 && $url ]] && { echo "$url"; return; } || { echo "$result" | perl -ne 'print if s/.*<message>(.*)<\/message>.*/\1/i' >&2; return 1; }
}


# Get first selected file in Finder
file="$(osascript -e 'tell application "Finder" to get POSIX path of (first item of (selection as alias list))')"

# Make sure it's the right file type
[[ $(echo "${file##*.}" | tr "[:upper:]" "[:lower:]") =~ ^($filetypes)$ ]] \
	|| ERROR "$file: invalid file" 2

result="$(imgur "$file")" || ERROR "$result" 2
echo "$result"
echo "$result" | pbcopy
open "$result"
