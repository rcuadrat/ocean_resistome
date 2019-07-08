#!/bin/bash


inreads=$(readlink -f ../TARA_ORFS)/
inlist=$(readlink -f ../TARA_ARGS)/


cd ${inreads}/ptn

for f in $(ls *.faa );do

sbatch -p dontuseme,himem -c 10 --mem=4gb -o ${f%.fa.faa}_faixd_ext_ptn.out << EOF
#!/bin/bash
module load samtools
xargs samtools faidx ${f} < ${inlist}${f%.fa.faa}.ptn_list > ${inlist}${f%.fa.faa}.ARGS_ptn
EOF

done


cd ${inreads}/nt

for f in $(ls *.fna );do
sbatch -p dontuseme,himem -c 10 --mem=4gb -o ${f%.fa.fna}_faixd_ext_nt.out << EOF
#!/bin/bash
module load samtools
xargs samtools faidx ${f} < ${inlist}${f%.fa.fna}.read_list > ${inlist}${f%.fa.fna}.ARGS
EOF

done

