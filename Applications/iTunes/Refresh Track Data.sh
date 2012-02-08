#!/usr/bin/env bash -l
count=0
input=$(osascript -ss -e 'tell application "iTunes" to return selection as list' \
	| perl -pe 's/^{||}$//g' \
	| perl -pe 's/,\s*/\n/g' \
	| perl -pe 's/^[\s]*$//g' )

total_lines=$(echo "$input" | wc -l)

echo "$input" | { while read line; do
	(( count++ ))
	[[ "$line" = "" ]] && continue
	
	echo "$count/$total_lines*100" | bc -l | xargs printf "%1.0f%% "
	osascript -sh -e "tell application \"iTunes\" to tell ${line} to return artist & \" - \" & name"
	osascript -ss -e "tell application \"iTunes\" to tell ${line} to refresh"
done; } | CocoaDialog progressbar --title "Refresh Track Data..."

