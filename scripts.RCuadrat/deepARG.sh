#!/bin/bash

inreads=$(readlink -f ../TARA_ORFS/nt)/
deep=$(readlink -f /beegfs/group_bit/home/RCuadrat/projects/Bioinformatics/bit_FLPA/scripts.RCuadrat/deeparg-ss)/


mkdir -p ../deeparg_out
out=$(readlink -f ../deeparg_out)/
logs=$(readlink -f ../slurm_logs)/

cd ${inreads}
for f in $(ls *.fna );do
echo $f
sbatch -c 18 -p hugemem,himem,blade -o ${logs}deep_${f}.%j.out << EOF
#!/bin/bash
python ${deep}deepARG.py --align --type nucl --genes --input $f --output ${out}${f%.fna}.out
EOF
done

