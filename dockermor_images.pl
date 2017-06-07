#!/usr/bin/perl
#
# @File docker mor.pl
# @Author qubsup
# @Created May 30, 2017 10:27:01 AM
#


my $imd = qx/docker images  --format "{{.ID}}: {{.CreatedSince}}" | grep -i days/;


foreach my $d (split(/\n/, $imd)){
	my @words = split(' ', $d);
   	my $daily = $words[1];
      	if ($daily >= 1){
          system("docker rmi -f $words[0]") == 0 or die('docker rmi failed');
          print "docker image $words[0] deleted";
        }  
}


my $imh = qx/docker images  --format "{{.ID}}: {{.CreatedSince}}" | grep -i hours/;

foreach my $h (split(/\n/, $imh)){
	my @words = split(' ', $h);
	my $houry = $words[1];
	if ($hourly >= 3){          
          system("docker rmi -f $words[0]") == 0 or die('docker rmi failed');
          print "docker image $words[0] deleted";
         }  
       
};
