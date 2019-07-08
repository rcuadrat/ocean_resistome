#!/bin/bash

inreads=$(readlink -f ../TARA_ORFS)/


logs=$(readlink -f ../slurm_logs)/

cd ${inreads}/nt

for f in $(ls *.fna );do
echo $f
sbatch -c 4 -p hugemem,himem,blade -o ${logs}fixheader_${f}.%j.out << EOF
#!/bin/bash
sed -i -e 's/>TARA/TARA/g' $f
EOF
done

cd ${inreads}/ptn

for f in $(ls *.faa );do
echo $f
sbatch -c 4 -p hugemem,himem,blade -o ${logs}fixheader_${f}.%j.out << EOF
#!/bin/bash
sed -i -e 's/>TARA/TARA/g' $f
EOF
done



