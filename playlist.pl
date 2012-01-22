#!/usr/bin/perl

@xmms = `COLUMNS=200 nyxmms2 list`;
@music = ();

@state = `xmms2 status`;

if ( @state[0] =~ /(.*):.*/ ) {
	$status = $1;
}

# Push - add to end
# Unshift - add to beginning
# Pop - remove from end
# Shift - remove from beginning

while (@xmms) {
    if ( @xmms[0] =~ /\s*(->)?(\[\d+.*\])\s*(.*) - (.*) \((.+:.+)\)/ ) {
        my $playing = $1;
        my $tracknum = $2;
        my $artist = $3;
        my $song = $4;
        my $time = $5;

        $tracknum =~ s/\[(\d+)\/\d+\]/\1/;

        push(@music, [$playing,$tracknum,$artist,$song,$time]);
        shift(@xmms);
    } elsif ( @xmms[0] =~ /\s*Total playtime: (.*)/ )  {
        $total = $1;
        shift(@xmms);
    } else {
        shift(@xmms);
    }
}

print "<table class=\"tracklist\">\n";
print "<tr class=\"trackhead\">\n";
print "<td></td>";
print "<th style=\"text-align:right\">#</th>";
print "<th>Song</th>";
print "<th>Time</th>";
print "<th>Artist</th>";
print "<th>Remove</th>";
print "</tr>\n";

$count = 0;
foreach (@music) {
    ($playing,$track,$artist,$song,$time) = @{$_};
    print "<tr class=\"";
    if ( $playing ) {
        print "playing";
    } else {
        print (($count % 2 == 0) ? "even" : "odd");
    }
    print "\">\n";

    print "<td>";
    if ( $playing ) {
        print (($status =~ /Playing/) ? "&gt;&gt;&gt;" : "###");
    }
    print "</td>\n";
    print "<td class=\"tracknum\">";
    print "<a href=\"#\" onclick=\"jumpSong('$track')\">$track</a>";
    print "</td>\n";
    print "<td>$song</td>\n";
    print "<td class=\"time\">$time</td>\n";
    print "<td>$artist</td>\n";
    print "<td class=\"rm\">";
    print "<a href=\"#\" onclick=\"removeSong('$track')\">X</a></td>";

    print "</tr>\n";
    $count++;
}

print "<tr class=\"total\">\n";
print "<td></td>";
print "<td>Total</td>\n";
print "<td></td>\n";
print "<td class=\"time\">$total</td></tr>\n";

print "</table>\n";
