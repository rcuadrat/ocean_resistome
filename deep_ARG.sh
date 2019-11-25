#!/bin/bash
# Script number 5 resistomedb
#Run deepARG for all NT sequences 

inreads=$(readlink -f ORFS/nt)/
DEEPARG_DATA=$(readlink -f ORFS/nt)/

mkdir -p deeparg_out

cd ${inreads}
for f in $(ls *.fna );do
echo $f
docker run --rm -it -v $DEEPARG_DATA:/data/ gaarangoa/deeparg:v1.0.1 python /deeparg/deepARG.py --align --type nucl --genes --input /data/$f --output /data/${f%.fna}.out

done


mv *ARG* ../../deeparg_out

cd ../..