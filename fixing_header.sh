#!/bin/bash
# Script 3 resistomeDB
# Fixing headers in ORF's fasta for ptn and nt sequences (metagenemark generate a header with ">" on description that leads
# for crashing in some tools, and also create some empty space in the beggining of some fastas that also leads to problems

inreads=$(readlink -f ORFS)/

cd ${inreads}/nt

for f in $(ls *.fna );do
    echo $f
    sed -i -e 's/>TARA/TARA/g' $f &
done
wait

for f in $(ls *.fna );do
    echo $f
    sed -i -e '/./,$!d' $f &

done
wait


cd ${inreads}/ptn

for f in $(ls *.faa );do
    echo $f
    sed -i -e 's/>TARA/TARA/g' $f &
done
wait

for f in $(ls *.faa );do
    echo $f
    sed -i -e '/./,$!d' $f &
done
wait

cd ../..