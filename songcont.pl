#!/usr/bin/perl

print "<h1>Sangs</h1>\n\n";

print '<div id="songlist">';
print `./playlist.pl`;
print '</div>';

print '<div id="status">';
print `./status.pl`;
print "</div>";


