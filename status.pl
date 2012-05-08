#!/usr/bin/perl

@state = `nyxmms2 current -r 0`;

if ( @state[0] =~ /(.*):.*/ ) {
    $status = $1;
}

if ( @state[0] =~ /.*(\d+):(\d\d) of (\d+):(\d\d)/ ) {
    $place = $1 * 60 + $2;
    $total = $3 * 60 + $4;
    $remaining = $total - $place;
}

print '<div id="controls">';
print "<p>\n";

print "<a href=\"#\" onclick=\"control('prev')\">&lt;</a>\n";
print "<a href=\"#\" onclick=\"control('toggle')\">";
if ( $status =~ /Stopped|Paused/ ) {
	print "Play";
} elsif ( $status == "Playing" ) {
	print "Pause";
}
print "</a>\n";
print "<a href=\"#\" onclick=\"control('next')\">&gt;</a>\n";
print "</p>\n\n";
print "</div>\n";

print "<p>";
foreach (@state) {
	print "$_<br  />\n";
}
print "</p>";

if ($remaining && $status == "Playing") {
    print qq(
    <script>
        delayedRefresh($remaining);
    </script>
    )
}
