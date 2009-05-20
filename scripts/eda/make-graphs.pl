#!/usr/bin/perl -w
#
#  Make a .dat file for each .err file.
#

$gnuplot = "plot";
$first = 1;
foreach $f (split(/[\r\n]+/, `ls [0-9]*err`)) {
    ($fnew = $f) =~ s/err/dat/;
    die $! if $fnew eq $f;
    print STDERR "$f => $fnew\n";
    $cmd = "cat $f | grep FINAL | cut -d ' ' -f 6,9 | perl -ne 's/[:,]//g; print' > $fnew";
    print STDERR "$cmd\n";
    system($cmd);
    $gnuplot .= "," unless $first;
    $first = 0;
    $gnuplot .= " \\\n\t'$fnew' with lp"
}
print "$gnuplot\n";