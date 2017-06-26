#!/usr/bin/perl

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
# @File docker mor.pl
# @Author qubsup - with the help of Dr. Ondrej Guth and Biser Milanov
# @Created May 30, 2017 10:27:01 AM
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
use Date::Parse;

use Getopt::Long qw(GetOptions);
Getopt::Long::Configure(qw(posix_default no_ignore_case));

use POSIX qw(strftime);
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
my $command_line_options = (
    all             => 0,
    dry_run         => 0,
    dry_run_prefix  => "[DOCKERMOR DRY RUN]: ",
    older_than_days => 0,
    resource_type   => ""
);

my $docker_images_query = qx/docker images --format "{{.ID}}:\t{{.CreatedAt}}\t{{.Repository}}"/;
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
GetOptions(
    "all"               => \$command_line_options{all},
    "dry-run"           => \$command_line_options{dry_run},
    "dry-run-prefix=s"  => \$command_line_options{dry_run_prefix},
    "older-than-days=i" => \$command_line_options{older_than_days},
    "resource-type=s"   => \$command_line_options{resource_type}
) or die "Please provide the correct arguments";

# TODO: How to keep previous values with Getopt::Long?
if ($command_line_options{dry_run_prefix} == "")
{
    $command_line_options{dry_run_prefix} = "[DOCKERMOR DRY RUN]: ";
}

# Create a hash from the rest of the command line input
my %requested_resoures = map { $_ => 1 } @ARGV;
# ---------------------------------------------------------------------------- #

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
if ($command_line_options{resource_type} == "image")
{
    foreach my $row (split(/\n/, $docker_images_query))
    {
        my @columns       = split('\t', $row);
        my $creation_date = str2time($columns[1]);
        my $image_name    = $columns[2];
        my $cutoff_date   = time() - ($command_line_options{older_than_days} * 24 * 60 * 60);

        if (($command_line_options{"all"} || exists($requested_resoures{$image_name})) &&
            $cutoff_date > $creation_date)
        {
            if ($command_line_options{dry_run} == 1)
            {
                print "$command_line_options{dry_run_prefix}docker image $image_name will be deleted\n";
            }
            else
            {
                system("docker rmi -f $image_name") == 0 or die('could not remove docker image $image_name');
                print "docker image $image_name deleted\n";
            }
        }
    }
}
# ---------------------------------------------------------------------------- #
