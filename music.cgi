#!/usr/bin/perl

print "Content-type: text/html\n\n";

@header = `cat head.htm`;
@footer = `cat foot.htm`;

eval `cat query.pl`;

$path = $query{'path'};
$path =~ s/&/%26/;

@xmms = `COLUMNS=200 nyxmms2 list`;
@music = ();

print @header;
print "</head>\n";
print "<body>\n";

print '<div id="songcont">';
print `./songcont.pl`;
print '</div>';

## File browser
#
print '<div id="filecont">';
print `./files.pl`;
print '</div>';

print @footer;
