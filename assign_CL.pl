%pos=
(
	"17858_A|G"=>[3],
	"28144_T|C"=>[2,3,4],
	"14805_C|T"=>[4,9],
	"14408_C|T"=>[5,6,7,8,13,14,15,16,17,18,19,20,21,22],
	"23403_A|G"=>[5,6,7,8,13,14,15,16,17,18,19,20,21,22],
	"26144_G|T"=>[9,10],
	"25563_G|T"=>[7,8,14,17],
	"1397_G|A"=>[11],
	"1059_C|T"=>[7,8],
	"28863_C|T"=>[4],
	"11916_C|T"=>[8],
	"3037_C|T"=>[5,6,7,8,13,14,15,16,17,18,19,20,21,22],
	"28881_G|A"=>[5,6,15,20,22],
#	"28882_G|A"=>[5,6],
#	"28883_G|C"=>[5,6],
	"23731_C|T"=>[6],
	"8782_C|T"=>[2,3,4],
	"18060_C|T"=>[3],
	"13730_C|T"=>[12],
	"2558_C|T"=>[10],
	"29540_G|A"=>[8],
	"18998_C|T"=>[8],
	"17747_C|T"=>[3],
	"29742_G|T"=>[11],
	"28657_C|T"=>[4],
	"9477_T|A"=>[4],
	"25979_G|T"=>[4],
	"6312_C|A"=>[12],
	"28311_C|T"=>[12],
	"28688_T|C"=>[11],
	"10097_G|A"=>[6],
	"23929_C|T"=>[12],
	"11083_G|T"=>[9,10,11,12,22],
	"2480_A|G"=>[10],
	"17247_T|C"=>[9],
	"20268_A|G"=>[13,15],
	"28854_C|T"=>[13],
	"18877_C|T"=>[14,17],
	"26735_C|T"=>[14,17],
	"4002_C|T"=>[6],
	"13536_C|T"=>[6],
	"1163_A|T"=>[15,22],
	"22992_G|A"=>[15,17],
	"7540_T|C"=>[15],
	"16647_G|T"=>[15],
	"18555_C|T"=>[15],
	"23401_G|A"=>[15],
	"17104_C|T"=>[16],
	"22879_C|A"=>[16],
	"4543_C|T"=>[17],
	"9526_G|T"=>[17],
	"17019_G|T"=>[17],
	"25710_C|T"=>[17],
	"445_T|C"=>[18,21],
	"6286_C|T"=>[18,21],
	"21255_G|C"=>[18,21],
	"22227_C|T"=>[18,21],
	"26801_C|G"=>[18,21],
	"28932_C|T"=>[18,21]
	"29645_G|T"=>[18,21],
	"21614_C|T"=>[21],
	"27944_C|T"=>[21],
	"10319_C|T"=>[19],
	"27964_C|T"=>[19],
	"8683_C|T"=>[20],
	"15406_G|T"=>[20],
	"21637_C|T"=>[20],
	"28169_A|G"=>[20],
	"3256_T|C"=>[22],
	"5622_C|T"=>[22],
	"14202_G|T"=>[22],
	"19542_G|T"=>[22],
	"19718_C|T"=>[22],
	"22388_C|T"=>[22],
	"26060_C|T"=>[22],
	"29227_G|T"=>[22],
	"29466_C|T"=>[22]
);

print "name c1 c2 c3 c4 c5 c6 c7 c8 c9 c10 c11 c12 c13 c14 c15 c16 c17 c18 c19 c20 c21 c22\n";
@files=<*_ref_qry.snps>;
@genomes=();
foreach $f (@files)
{
	$name=$f;
	$name=~s/_ref_qry.snps//;
	$name=~s/\.\d+//;
        my @scores=(-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
	%Ihave=();	

	#next if $name=~/EPI_ISL_402131/ || $name=~/EPI_ISL_410721/;
	open(IN,$f);
	%ldata=();
	while(<IN>)
	{
		next unless $_=~/NC_045512.2/;
                ($pos,$b1,$b2)=(split(/\s+/,$_))[1,2,3];
		$label="$pos\_$b1|$b2";
		next if $pos<=250 || $pos>29700;
		$Ihave{$label}=1;
	}
	foreach $pos (sort {$a<=>$b} keys %pos)
	{
		@clusters=@{$pos{$pos}};
		if ($Ihave{$pos})
		{
			foreach $cl (@clusters)
			{
				$scores[$cl]+=3;
			}
		}else{
			foreach $cl (@clusters)
                        {
                                $scores[$cl]-=1;
                        }
		
		}		
	}
	my $max=-100;
	my $i=0;
	my $imax=0;
	foreach $s (@scores)
	{
		$imax=$i if $s>$max;
		$max=$s if $s>$max;
		$i++;
	}
	shift(@scores);
	$imax=1 if $imax==0;
	print "$name @scores $imax\n";
}
