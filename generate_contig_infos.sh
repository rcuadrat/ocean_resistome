#!/bin/bash

# Script number 4 on resistomeDB

# create tables with extrated information from headers of ORFs, 1st column gene ID and secound column contig ID
# This will be used to merge with further tables
# Also, generate a table with number of contigs per co-assembly 

inreads=$(readlink -f ORFS)/



for f in $(ls ${inreads}/nt/*.fna) 

do 
    grep ">" $f > ${f%.fa.fna}_orf_contigs.tsv &

done 
wait

for f in $(ls ${inreads}/ptn/*.faa)
do 
    grep ">" $f > ${f%.fa.faa}_orf_contigs.tsv &
done 
wait

mkdir -p TSV

cd ${inreads}/nt
find *.fna -printf 'echo %p\t"$(grep -c ">" %p )";' | sh > ../../TSV/orf_numbers.tsv

# Call the python/pandas script that concatanate the "orf_contigs.tsv" tables, for all co-assemblies and ptn/nt IDs 
cd ../..

python contig_gene_id_table_generator.py