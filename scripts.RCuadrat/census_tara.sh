#!/bin/bash

inreads=$(readlink -f ../reads)/
mkdir -p ../census_tara
logs=$(readlink -f ../slurm_logs)/
cd ${inreads}

for f in $(ls *_1.fastq.gz);do
echo $f	
sbatch -c 10 --mem=16gb -o ${logs}census_${f%_1.fastq.gz}.%j.out << EOF
#!/bin/bash
run_microbe_census.py -t 10  ${f},${f%_1.fastq.gz}_2.fastq.gz ../census_tara/${f}.census
EOF
done

