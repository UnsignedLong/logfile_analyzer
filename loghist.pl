#!/usr/bin/perl

use strict;
use warnings;

use Text::BarGraph;

sub usage()
{
    print STDERR << "EOF";
Example: $0 /some/file.log
Example: $0 /some/file.log "Search pattern"
EOF
      exit;
}

my $myfile = $ARGV[0] || usage();
my $graph = Text::BarGraph->new();

my %hour_count_hashmap;

for my $num ("00" .. "23") {
  $hour_count_hashmap{ $num } = 0;
}

my $filter = $ARGV[1] || '';

open(FILE,"<".$ARGV[0]);
while(<FILE>) {
  if($_ =~ m/[ :-]([0-9]{2}):[0-9]{2}:.*$filter.*/) {
    $hour_count_hashmap{ $1 } += 1;
  }
}

close FILE;
$graph->columns(80);
$graph->autosize(0);
$graph->enable_color(1);
print $graph->graph(\%hour_count_hashmap);
