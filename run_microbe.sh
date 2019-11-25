#!/bin/bash

inreads=$(readlink -f reads)/
mkdir -p census_out
census=$(readlink -f census_out)/

cd ${inreads}

for f in $(ls *_1.fastq.gz);do
echo $f
    run_microbe_census.py -t 10  ${f},${f%_1.fastq.gz}_2.fastq.gz ${census}/${f}.census
done