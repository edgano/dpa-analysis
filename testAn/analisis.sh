#!/bin/bash
FILES="./*.dpa_1000.CLUSTALO.with.CLUSTALO.tree.parent.aln"
#*.dpa_1000.CLUSTALO.with.CLUSTALO.tree.parent.aln"
#*.dpa_1000.CLUSTALO.with.MAFFT_PARTTREE.tree.parent.aln
#*.dpa_1000.MAFFT-FFTNS1.with.CLUSTALO.tree.parent.aln
#*.dpa_1000.MAFFT-FFTNS1.with.MAFFT_PARTTREE.tree.parent.aln
prefix="./";
suffix=".aln";
outputFolder="./resultsCO_CO" # resultsCO_MA resultsMA_CO MA_MA

for file in $FILES
do
  string=${file#$prefix}; #Remove prefix
  string=${string%$suffix}; #Remove suffix
  stdout="$outputFolder/std/$string.stdout"
  infoOut="$outputFolder/info/$string.info"
  sum="$outputFolder/sum/$string.sum"
  AvgSum="$outputFolder/avgSum/$string.avgSum"
  AvgID="$outputFolder/avgID/$string.avgID"

  echo "Processing $string file..."
  ## Infomation Content
  esl-alistat --icinfo $infoOut $file  > $stdout

  ## Sum
  awk 'NR > 8 && $1 ~// { sum+= $3 } END {print sum}' $infoOut > $sum

  ## Average Sum
  awk 'NR > 8 && $1 ~// { sum+= $3 } END {print sum/(NR-9)}' $infoOut > $AvgSum

  ## Average Identity
  awk 'NR==9 {$3=substr($3,1,length($3)-1);print $3}' $stdout > $AvgID

done