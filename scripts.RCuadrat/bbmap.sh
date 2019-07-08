#!/bin/bash


inreads=$(readlink -f ../reads)/
inref=/beegfs/group_bit/data/projects/departments/Bioinformatics/bit_resistome/TARA_ORFS/nt/all_orfs_tara.fna
out=/beegfs/group_bit/data/projects/departments/Bioinformatics/bit_resistome/cov_all_tara_orfs
logs=$(readlink -f ../slurm_logs)/

cd ${inreads}

	for f in $(ls *1.fastq.gz );do
sbatch -p hugemem -c 18 -o ${logs}/${f%.fastq.gz}_bbmap.%j.out << EOF
#!/bin/bash
module load java
bbmap.sh touppercase=t ref=${inref}  scafstats=${out}/ALL_ARG_${f%_1.fastq.gz}.cov  in1=$f in2=${f%1.fastq.gz}2.fastq.gz out=${out}/ALL_ARG_${f%_1.fastq.gz}.sam rpkm=${out}/ALL_ARG_${f%_1.fastq.gz}.rpkm 
rm ${out}/ALL_ARG_${f%_1.fastq.gz}.sam
EOF

done
