#!/bin/bash
# Second scripts resistomeDB
# Extract ORFs with metagenemark for all co-assemblies
# Please, first install metagenemark on project folder (download from here http://exon.gatech.edu/license_download.cgi)
# you have to provide email and get the registration key, uncompress the key for your home folder and rename it for .gm_key

inreads=$(readlink -f CONTIGS)/
mkdir -p ORFS
out=$(readlink -f ORFS)/

mkdir -p ${out}/nt
mkdir -p ${out}/ptn
mkdir -p ${out}/metagenemark_out

cd ${inreads}

for f in $(ls *.fa );do
    echo $f
    #harcoded for the folder created when uncompress linux_64 version (the one we tested)
    ../MetaGeneMark_linux_64/mgm/./gmhmmp -f G -a -d -m  ../MetaGeneMark_linux_64/mgm/MetaGeneMark_v1.mod $f -D ${out}/nt/$f.fna -A ${out}/ptn/$f.faa -f G -o ${out}/metagenemark_out/$f.gff  &
    
done
wait
echo "MetageneMark done" 

