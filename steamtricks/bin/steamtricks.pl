#!/usr/bin/env perl

use strict;
use warnings;

use Getopt::Long;
use Config::Tiny;
use File::Basename;

sub setup_config;
sub print_help;
sub main;
sub parse_config;

use constant {
    VERSION = "v0.1.0"
}

my $steamtricks_prefix = $ENV{'STEAMTRICKS_PREFIX'};
my $change_install = '';
my $create_install = '';
my $new_config = '';
my $game = '';
my $game_version = '';
my $new_steam_prefix = '~/.var/app/com.valvesoftware.Steam/data/Steam/steamapps/common';
my $help = '';
my $version = '';
my $config_location = "${steamtricks_prefix}/steamtricks.conf"

GetOptions ('steam-prefix=s' => \$steam_prefix, 
    'create-install' => \$create_install,
    'change-install' => \$change_install,
    'game=s' => \$game,
    'setup-config' => \$new_config,
    'steam-prefix=s' => \$new_steam_prefix,
    'game-version=s' => \$game_version,
    'help' => \$help,
    'version' => \$print_version);

main;

sub main {

    if ($help) {
        print_help;
        return 0;
    } else if ($version) {
        print basename($0), VERSION;
    } else if ($new_config) {
        setup_config($new_steam_prefix)
    } else if ($change_install && $game_version) {
        
    } else if ($create_install && $game_version) {

    }

}

sub parse_config {

    if (-s "$config_location" ) {
        my $config = Config::Tiny->read( "$config_location" );
    } else {
        warn "config file ${config_location} not found. Creating new config with flatpak defaults\n";
        setup_config;
    }   
}

sub setup_config {

    print "Creating config with STEAM_PREFIX=${new_steam_prefix}\n"
    if (-s "${config_location}") {
        warn "$config_location already exists, do you wish to overwrite this file? [y/N]";
        my $ans = <STDIN>;
        chomp $ans;

        switch($ans) {
            case /[yY].?/ { my $config = Config::Tiny->new({ _ => { STEAM_PREFIX => "$new_steam_prefix" } }) }
            else { die "Config not created. Exiting" }
        }

    } else {
        my $config = Config::Tiny->new({ _ => { STEAM_PREFIX => "$new_steam_prefix" }});;
    }

    $config->write( ${config_location} ) or die "Config file $config_location could not be written: $!\n";

}

sub print_help {
    print basename($0), "\n";
}