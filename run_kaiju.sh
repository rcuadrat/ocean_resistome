#!/bin/bash

# Script 10 resistomeDB
# Run Kaiju


contigsall=$(readlink -f CONTIGS/all)/
inlist=$(readlink -f ARGS)/

kaiju -t ../kaiju/bin/nodes.dmp -f ../kaiju/bin/nr_euk/kaiju_db_nr_euk.fmi -i ${contigsall}/all_contigs_with_args.fasta -o kaiju_on_contigs.out -z 36 -v

kaiju -t ../kaiju/bin/nodes.dmp -f ../kaiju/bin/nr_euk/kaiju_db_nr_euk.fmi -i ${inlist}/ALL_ARGS.fasta -o kaiju_on_ARGs.out -z 36 -v