#!/bin/bash

mkdir -p bbmap_out

inreads=$(readlink -f reads)/
inref=$(readlink -f ARGS/ALL_ARGS.fasta)
out=$(readlink -f bbmap_out)/

cd ${inreads}

for f in $(ls *1.fastq.gz );do
    bbmap.sh touppercase=t ref=${inref}  scafstats=${out}/ALL_ARG_${f%_1.fastq.gz}.cov  in1=$f in2=${f%1.fastq.gz}2.fastq.gz out=${out}/ALL_ARG_${f%_1.fastq.gz}.sam rpkm=${out}/ALL_ARG_${f%_1.fastq.gz}.rpkm 
rm ${out}/ALL_ARG_${f%_1.fastq.gz}.sam
done