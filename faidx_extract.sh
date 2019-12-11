#!/bin/bash

# Script 7 from resistomeDB
# Extract ORFs annotated as ARG by deepARG from the total big multi-fastas with all ORFs
# Extract contig sequences with at least  one  ARG by deepARG from the total big multi-fastas with all contigs (for PlasFlow)
# Extract all ORFs of all contigs with at least one ARG

inreads=$(readlink -f ORFS)/
inlist=$(readlink -f ARGS)/
contigsall=$(readlink -f CONTIGS/all)/
#mkdir -p contigs_with_args_orfs

cd ${inreads}/ptn

for f in $(ls *.faa );do
    xargs samtools faidx ${f} < ${inlist}${f%.fa.faa}.ptn_list > ${inlist}${f%.fa.faa}.ARGS_ptn &

done
wait

cd ${inreads}/nt

for f in $(ls *.fna );do

    xargs samtools faidx ${f} < ${inlist}${f%.fa.fna}.read_list > ${inlist}${f%.fa.fna}.ARGS &

done
wait

cd $contigsall
xargs samtools faidx all_contigs.fa < all_contigs_with_args.list > all_contigs_with_args.fasta

cd ${inreads}/nt
for f in $(ls *.fna); 
do 
    xargs samtools faidx $f < ${f%.fa.fna}_orfs_in_contigs_with_args.list > ${f%.fa.fna}.args_orfs.fna;
done


cd ${inlist}

for f in $(ls *.ARGS);
do 
    awk -v var=${f%.ARGS} '/^>/ {$0=$0 "|"var}1' $f > $f.edit.fasta; 
done

for f in $(ls *.ARGS_ptn);
do 
    awk -v var=${f%.ARGS_ptn} '/^>/ {$0=$0 "|"var}1' $f > $f.edit.ptn.fasta; done


cat *.edit.fasta  > ALL_ARGS.fasta
cat *.edit.ptn.fasta  > ALL_ARGS_ptn.fasta

cd ..