#!/usr/bin/perl


$absolute="/home/dmitri/Music/";

opendir(DIR, $absolute);

@files = grep !/^\.\.?$/, readdir(DIR);

foreach $file (@files) {
	print "\"$file\"\n";
}

closedir(DIR);
