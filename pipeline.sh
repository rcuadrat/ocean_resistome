#!/bin/bash

# ResistomeDB pipeline

echo "Downloading and extracting contigs"

bash get_contigs.sh

echo "Running MetageneMark"

bash run_metagenemark.sh

echo "Working on headers of ORFs"

bash fixing_header.sh

echo "Generating stats from contigs/orfs" 

bash generate_contig_infos.sh

echo "Running deepARG on ORFs"

bash deep_ARG.sh

echo "Parsing deepARG results"

python3 parser_deepARG.py

echo "Extracting ORFs/ARGs and contigs with ORFs/ARGs"

bash faidx_extract.sh

echo "Runing PlasFlow on contigs with ARGs"

bash run_plasFlow.sh

echo "Parsing PlasFlow results" 

python3 parser_plasflow.py

echo "Running kaiju on contigs and ORFs"

bash run_kaiju.sh

echo "parsing kaiju and generating headers for phylogeny"

python3 parser_kaiju.py

echo "get fasta for phylogenetic trees"

bash get_fasta_phy.sh

echo "get reads" 

bash get_data.sh

echo "run MicrobeCensus"

python run_microbe.sh

echo "parsing census"

python parser_census.py

echo "run bbmap"

bash run_bbmap.sh

echo "parsing bbmap"

python parser_bbmap.py
