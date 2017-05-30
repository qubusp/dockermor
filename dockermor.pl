#!/usr/bin/perl
my $imd = exec 'docker images  --format "{{.ID}}: {{.CreatedSince}}"|grep -i days';


my @imagesd = qw($imd);
foreach $d (@imagesd){
    
   my $daily = $d[2];
      if ($daily => 1){
          
          exec 'docker rmi $d[1]';
          print "docker image $d[1] deleted";
         }  
       
    };
my $imh = exec 'docker images  --format "{{.ID}}: {{.CreatedSince}}" |grep -i hours ';

my @imagesh = qw($imh);
foreach $h (@imagesh){
    
   my $houry = print "$h[3]";
      if ($hourly => 1){
          
          exec 'docker rmi $h[1]';
          print "docker image $h[1] deleted";
         }         
    };
