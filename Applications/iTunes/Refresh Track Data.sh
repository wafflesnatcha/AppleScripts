#!/usr/bin/env bash -l
count=0
input=$(osascript -ss -e 'tell application "iTunes" to return selection as list' \
	| perl -pe 's/^{||}$//g' \
	| perl -pe 's/,\s*/\n/g' \
	| perl -pe 's/^[\s]*$//g' )

total_lines=$(echo "$input" | wc -l)

cocoadialog="$(which CocoaDialog 2>/dev/null)"

( echo "$input" | { while read line; do
	(( count++ ))
	[[ "$line" = "" ]] && continue
	percent=$(echo "$count/$total_lines*100" | bc -l | xargs printf "%1.0f%%")
	echo -n "$percent $percent "
	osascript -sh -e "tell application \"iTunes\" to tell ${line} to return artist & \" - \" & name"
	osascript -ss -e "tell application \"iTunes\" to tell ${line} to refresh"
done; } | { [[ $cocoadialog ]] && "$cocoadialog" progressbar --title "Refresh Track Data..."; } ) &>/dev/null &

