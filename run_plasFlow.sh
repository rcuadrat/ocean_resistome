#!/bin/bash

# Script 8 resistomeDB
# Run PlasFLow

# this script runs plasflow installed on conda env

##################################################
# conda config --add channels bioconda           #
# conda config --add channels conda-forge        #
# conda create --name plasflow python=3.5        #
# conda activate plasflow                        #
# conda install -c jjhelmus tensorflow=0.10.0rc0 #
# conda install plasflow -c smaegol              #
##################################################

source ~/anaconda3/etc/profile.d/conda.sh 
eval "$(conda shell.bash hook)"
conda activate plasflow

contigsall=$(readlink -f CONTIGS/all)/
mkdir -p plasflowout

PlasFlow.py --input ${contigsall}/all_contigs_with_args.fasta --output plasflowout/all_with_args.plasflowout --threshold 0.7

conda deactivate