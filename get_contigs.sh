#!/bin/bash

# First script from resistomedb 
# Download and extract contigs from http://merenlab.org/data/tara-oceans-mags/ paper

mkdir -p CONTIGS
cd CONTIGS
wget -O contigs.zip https://ndownloader.figshare.com/articles/4902920/versions/1 
unzip contigs.zip
gunzip *.gz
find *.fa -printf 'echo %p\t"$(grep -c ">" %p )";' | sh > contig_numbers.tsv
mkdir -p all
cat *.fa > all/all_contigs.fa