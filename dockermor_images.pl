#!/usr/bin/perl
#
# @File docker mor.pl
# @Author qubsup - with the help of Dr. Ondrej Guth
# @Created May 30, 2017 10:27:01 AM
#
use Getopt::Long;
my $ha;
my $da;
my $mo;
my $we;
GetOptions('ha=i' => \$ha,
           'da=i' => \$da,
           'mo=i' => \$mo,
           'we=i' => \$we
) or die "Please use -h to set hours or -d to set days old image\n";
if ($da >= 0 ){
my $imd = qx/docker images  --format "{{.ID}}: {{.CreatedSince}} {{.Repository}}" | grep -i days/;
foreach my $d (split(/\n/, $imd)){
	my @words = split(' ', $d);
   	my $daily = $words[1];
      	if ($daily >= $da){
          system("docker rmi -f $words[3]") == 0 or die('docker rmi failed');
          print "docker image $words[3] deleted";
        }  
}};

if ($ha >= 0 ) {
my $imh = qx/docker images  --format "{{.ID}}: {{.CreatedSince}} {{.Repository}}" | grep -i hours/;

foreach my $h (split(/\n/, $imh)){
	my @words = split(' ', $h);
	my $houry = $words[1];
	if ($hourly >= $ha){          
          system("docker rmi -f $words[3]") == 0 or die('docker rmi failed');
          print "docker image $words[3] deleted";
         }  
       
}};


if ($mo >= 0 ){
my $imm = qx/docker images  --format "{{.ID}}: {{.CreatedSince}} {{.Repository}}" | grep -i month/;
foreach my $d (split(/\n/, $imm)){
	my @words = split(' ', $d);
   	my $monthly = $words[1];
      	if ($monthly >= $mo){
          system("docker rmi -f $words[3]") == 0 or die('docker rmi failed');
          print "docker image $words[3] deleted";
        }  
}};

if ($we >= 0 ){
my $imw = qx/docker images  --format "{{.ID}}: {{.CreatedSince}} {{.Repository}}" | grep -i week/;
foreach my $d (split(/\n/, $imw)){
	my @words = split(' ', $d);
   	my $weekly = $words[1];
      	if ($weekly >= $we){
          system("docker rmi  $words[3] -f") == 0 or die('docker rmi failed');
          print "docker image $words[3] deleted";
        }  
}};
