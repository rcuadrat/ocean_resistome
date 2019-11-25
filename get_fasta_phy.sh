#!/bin/bash

# Script 12 resistomeDB
# generate fasta with good headers for phylogeny


cd ARG_ORFs_lists
for f in $(ls *.list);
do 
    xargs samtools faidx ../ARGS/ALL_ARGS.fasta <  $f > ${f%.list}.fasta;
done

cd ptn
for f in $(ls *.list);
do 
    xargs samtools faidx ../../ARGS/ALL_ARGS_ptn.fasta <  $f > ${f%.list}.fasta;
done

for f in $(ls *.list_toedit);
do
    seqkit replace -p "(.+)" -r '{kv}' -k $f ${f%.list_toedit}.fasta > ${f%.list_toedit}.edit.fasta
done

cd ..
for f in $(ls *.list_toedit);
do
    seqkit replace -p "(.+)" -r '{kv}' -k $f ${f%.list_toedit}.fasta > ${f%.list_toedit}.edit.fasta
done
cd ..

mkdir ARG_fastas
mkdir ARG_fastas/ptn
mkdir ARG_fastas/nt

mv ARG_ORFs_lists/*.edit.fasta ARG_fastas/nt
mv ARG_ORFs_lists/ptn/*.edit.fasta ARG_fastas/ptn
