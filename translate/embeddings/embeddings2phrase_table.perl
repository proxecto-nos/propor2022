#!/usr/bin/perl -w

binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
use utf8;

$file = shift(@ARGV);
open (DICO, $file) or die "O ficheiro n�o pode ser aberto: $!\n";

##reading freeling dico
$token="";
while ($line = <DICO>) {
  chomp $line;
  if ($line !~ /[\w0-9]/){next}
  ($token, $lemma, $tag) = split (" ", $line);
  if (!$tag) {next}
  #print STDERR "#$token# - #$lemma# - #$tag#\n";
  $token = Trim ($token);
 

#  if ( $tag =~ /^V|^NC|^AQ|^NN|^JJ/) {
   if ( $tag =~ /^V/) {
    $Dico{$token}++
  }
}
 
while ($line = <STDIN>) {
  chomp $line;
  if ($line !~ /[\w0-9]/){next}
  ($ling1, $ling2, $peso) = split (" ", $line);
  $ling1 = Trim ($ling1);
  if ($Dico{$ling1}) {
      $ling2 =~ s/\(\'([\w]+)\'\,/$1/;
      $peso =~ s/([\w]+)\)/$1/;
      if ($ling1 eq $ling2) {next}
     
      print "$ling1\|\|\|$ling2\n" if ($peso >= 0.50);
      $ling1 = ucfirst ($ling1);
      $ling2 = ucfirst ($ling2);
      print "$ling1\|\|\|$ling2\n" if ($peso >= 0.50);
  }
}
  

sub Trim {
   local ($x) = $_[0];

   $x =~ s/^[\s]*//;
   $x =~ s/[\s]*$//;

   return $x;
}
