#!/usr/bin/perl
#
# @File dockermor.pl
# @Author qubsup
# @Created Jun 8, 2017 1:16:19 PM
#

#!/usr/bin/perl
#
# @File docker mor.pl
# @Author qubsup - with the help of Dr. Ondrej Guth
# @Created May 30, 2017 10:27:01 AM
use Getopt::Long qw(GetOptions);
Getopt::Long::Configure(qw(posix_default no_ignore_case));

my $imagename;
my %im = (
ima => "image",
vol => "volume",
); 
my %time = (
d => "day",
h => "hour",
W => "week",
mo => "month",
);
GetOptions(\%im, 'im=s',
\%time,  'time=i'

) or die "Please " unless exists $im{};
if ( $im == 'image' and defined $time not defined $imagename ){
my $imd = qx/docker images  --format "{{.ID}}: {{.CreatedSince}} {{.Repository}}" | grep -i $time  /; 
foreach my $d (split(/\n/, $imd)){
	my @words = split(' ', $d);
   	my $daily = $words[1];
      	if ($daily >= $time){
          system("docker rmi -f $words[3]") == 0 or die('docker rmi failed');
          print "docker image $words[3] deleted";
        }  
}};

if ( $im == 'image' and defined $time and defined $imagename){
my $imd = qx/docker images  --format "{{.ID}}: {{.CreatedSince}} {{.Repository}}" | grep -i $time | grep -i $imagename /; 
foreach my $d (split(/\n/, $imd)){
	my @words = split(' ', $d);
   	my $daily = $words[1];
      	if ($daily >= $time){
          system("docker rmi -f $words[3]") == 0 or die('docker rmi failed');
          print "docker image $words[3] deleted\n";
        }  
}};


