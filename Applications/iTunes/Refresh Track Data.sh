#!/usr/bin/env bash -l

refresh() {
	input=$(osascript -ss -e 'tell application "iTunes" to return selection as list' | perl -pe 's/^{||}$//g; s/,\s*/\n/g; s/^[\s]*$//g')
	total_lines=$(echo "$input" | wc -l)
	count=0
	echo "$input" | while read line; do
		(( count++ ))
		[[ "$line" = "" ]] && continue
		echo "$count/$total_lines*100" | bc -l | xargs printf "%1.0f%% "
		osascript -sh -e "tell application \"iTunes\" to tell ${line} to return artist & \" - \" & name"
		osascript -ss -e "tell application \"iTunes\" to tell ${line} to refresh"
	done
}

cocoadialog="$(which cocoaDialog 2>/dev/null)"
if [[ ! $cocoadialog || $TERM =~ ^xterm ]]; then
	refresh
else
	refresh | $cocoadialog progressbar --title "$(basename "$0" | sed -E 's/^(.*)\.[^\.]*$/\1/g')" --icon Music &
fi