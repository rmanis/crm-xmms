#!/usr/bin/perl

use File::Basename;

require "local.pl";
eval `cat query.pl`;
print "Content-type: text/html\n\n";

$musicpath = $query{'path'};
$command = $query{'cmd'};

if( $command =~ /play|pause|stop|next|prev|toggle|(jump \d+)|(remove \d+)/ ) {
    `nyxmms2 $command`;
}

if ( $command =~ /add (.*)/ ) {
    $mp3 = unlocalize($1);
    `nyxmms2 add "$mp3"`;
}

$musicpath =~ s/&/%26/;

print <<"EOF";

<html>
<head>
<meta http-equiv="REFRESH" content="0;url=music.cgi?path=$musicpath"
</head>
</html>

EOF


