#!/usr/bin/env bash -l

refresh() {
	local input total count=0

	input=$(osascript -ss -e 'tell application "iTunes" to return selection as list' | perl -pe 's/^{||}$//g; s/,\s*/\n/g; s/^[\s]*$//g')
	total=$(echo "$input" | wc -l | awk '{print $1}')

	echo "$input" | while read line; do
		((count++))
		[[ $1 ]] && echo $count $total | awk '{printf "%i%% ", $1/$2*100+.5}'
		echo -n "[$count/$total] "
		osascript -sh -e "tell application \"iTunes\" to tell ${line} to return artist & \" - \" & name"
		osascript -ss -e "tell application \"iTunes\" to tell ${line} to refresh"
	done
}

cocoadialog="$(which cocoaDialog 2>/dev/null)"
if [[ ! $cocoadialog || $TERM =~ ^xterm ]]; then
	refresh
else
	refresh | $cocoadialog progressbar --title "$(basename "$0" | sed -E 's/^(.*)\.[^\.]*$/\1/g')" --text "Starting..." --icon Music --stoppable &
fi