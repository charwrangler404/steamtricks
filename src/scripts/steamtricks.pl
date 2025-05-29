#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;

my $steam_prefix = $ENV{'STEAM_PREFIX'};
my $steamtricks_prefix = $ENV{'STEAMTRICKS_PREFIX'};
my $change_install = '';
my $game = '';
my $version = '';
my @games = split(/,/, $ENV{'SIM_MANAGED_GAMES'});

GetOptions ('steam-prefix=s' => \$steam_prefix, 
    'change-install' => \$change_install,
    'version=s' => \$version);