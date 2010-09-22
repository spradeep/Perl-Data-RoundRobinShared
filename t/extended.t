use Test::More;

my @data = qw/one two three four five/;
plan tests => (scalar(@data) * 3)+1;

use_ok('Data::RoundRobinShared');

our $rs1 = new Data::RoundRobinShared( key => 'Testm', data => [@data], simple_check => 1 );

for(my $i = 0; $i <= $#data; $i++)
{
	ok($rs1->next eq $data[$i],"Test $i");
}

our $rs2 = new Data::RoundRobinShared( key => 'Testm', data => [@data], simple_check => 1 );

my $j = 0;
for(my $i = 0; $i <= $#data;$i++)
{
	ok($rs1->next eq $data[$j++],"Obj 1 test $j");
	$j = 0 if($j > 4);
	ok($rs2->next eq $data[$j++],"Obj 2 test $j");
}

$rs1->remove;
