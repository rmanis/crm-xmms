#!/usr/bin/perl

use File::Basename;
use File::Spec;
use Cwd;

require "local.pl";
eval `cat query.pl`;

$path = $query{'path'};
$absolute = canonical_path("$prefix$path");
$absparent = dirname($absolute);

$path = localize($absolute);
$parent = localize($absparent);

$disppath = $path;
$path =~ s/&/%26/;
if($path) {
    $newpath = "$path/";
}

opendir(DIR, $absolute);
@files= grep !/^\..*$/, sort readdir(DIR);
foreach $file (@files) {
    if (-d "$absolute/$file" ) {
        push(@folders, $file);
    } else {
        push(@mp3s,$file);
    }
}
closedir(DIR);

if($path) {
    print "<h1>Files in \'$disppath\'</h1>\n";
} else {
    print "<h1>Files</h1>\n";
}

print "<table class=\"files\">\n";

print "<tr class=\"filehead\">\n";
print "<th>Add</th>\n";
print "<th>File</th>\n";
print "</tr>\n";

$count = 0;

if ( $path ) {
    print "<tr class=\"even\">\n";
    print "<td></td>\n";
    print "<td><a href=\"#\" onclick=\"navigate('$parent')\">Parent Directory</a></td>\n";
    print "</tr>\n";

    $count = 1;
}

foreach $file (@folders) {
    $safefile = $file;
    $safefile =~ s/&/%26/;
    print "<tr class=\"";
    print (($count % 2 == 0) ? "even" : "odd");
    print "\">\n";

    print "<td></td>\n";
    print "<td><a href=\"#\" onclick=\"navigate('$newpath$safefile')\">$file</a></td>\n";
    #print "<td><a href=\"music.cgi?path=$newpath$safefile\">$file</a></td>\n";

    print "</tr>\n";
    $count++;
}

foreach $file (@mp3s) {
    $safefile = $file;
    $safefile =~ s/&/%26/; # and per se and
    print "<tr class=\"";
    print (($count % 2 == 0) ? "even" : "odd");
    print "\">\n";

    print "<td><a onclick=\"addSong('$newpath', '$safefile')\" href=\"#\">+</a></td>\n";
    print "<td>$file</td>\n";

    print "</tr>\n";
    $count++;
}
print "<tr><td></td><td><a onclick=\"addAll('$newpath')\" href=\"#\">Add all</a></td></tr>\n";
print "</table>\n";
