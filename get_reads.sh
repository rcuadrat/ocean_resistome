#!/bin/bash

mkdir -p reads
cd reads

while IFS='' read -r line || [[ -n "$line" ]]; do


echo "Text read from file: $line"
    fastq-dump --gzip --split-files  $line

done < ../samples.list