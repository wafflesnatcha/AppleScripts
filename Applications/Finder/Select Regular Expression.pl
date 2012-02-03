#!/usr/bin/perl
# © Copyright 2005, Red Sweater Software. All Rights Reserved.
# Permission to copy granted for personal use only. All copies of this script
# must retain this copyright information and all lines of comments below, up to
# and including the line indicating "End of Red Sweater Comments".
#
# Any commercial distribution of this code must be licensed from the Copyright
# owner, Red Sweater Software.
#
# Requests a regular expression against which all items in the frontmost
# Finder window should be compared. Any item whose name matches the regular
# expression will be "selected" in the Finder.
#
# Version 1.0.1
#	Save the user's regular expression so we can pre-populate the dialog with it.
#
# Version 1.0
#	Initial release
#
# email: support@red-sweater.com
# web: http://www.red-sweater.com/AppleScript/
# End of Red Sweater Comments

use strict;

my $TempFilePath = "/tmp/com.red-sweater.script.regexCache";
my @matchPaths;
my $matchCount = 0;
my $pattern    = ".*";

# If the user didn't specify a regex on the command line, then ask the
# user by putting up a dialog in the Finder.
if ( @ARGV < 1 ) {

	# did we have a pattern last time? if so, use it
	if ( open( FH, $TempFilePath ) ) {
		$pattern = join( "", <FH> );
		close FH;
	}

	$pattern =
`osascript -e 'tell application \"Finder\"\nactivate\nreturn text returned of (display dialog "Please enter a regular expression:" default answer "$pattern")\nend tell\n'`;
	chomp($pattern);

	# save it for next time
	if ( open( FH, ">$TempFilePath" ) ) {
		print FH $pattern;
		close(FH);
	}
}
else {
	$pattern = $ARGV[0];
}

# Get a list of all the names of files in the targeted window of the Finder
my $allItems =
`osascript -e 'set allItems to {}\ntell application \"Finder\"\ntry\nset allItems to items of front window\non error\nset allItems to items of desktop\nend try\nend tell\nset allPaths to {}\nrepeat with bob in allItems\nset end of allPaths to POSIX path of \(bob as alias\)\nend repeat\nallPaths'`;
chomp($allItems);
my @allPaths = split( /, /, $allItems );

# Now identify matches, and for those items, pack the results up in an AppleScript friendly format
# ("POSIX file <blah>")
for ( my $counter = 0 ; $counter < scalar(@allPaths) ; $counter++ ) {

	# Compare against the leaf name only
	my @pathComponents = split( /\//, $allPaths[$counter] );
	my $thisLeaf = pop(@pathComponents);
	if ( $thisLeaf =~ /$pattern/ ) {
		my $thisSpec = "posix file \"" . $allPaths[$counter] . "\"";
		$matchPaths[ $matchCount++ ] = $thisSpec;
	}
}

# Now we need to convince Finder to select those items. To do so we
# turn the list of full POSIX paths into an AppleScript format (bracketed) list,
# which Finder's select command understands.
my $myScript =
		"tell application \"Finder\" to select {" . join( ", ", @matchPaths ) . "}\n";
`osascript -e '$myScript'`;

