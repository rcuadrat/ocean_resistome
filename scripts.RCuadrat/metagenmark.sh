#!/bin/bash

inreads=$(readlink -f ../TARA_CONTIGS)/
out=$(readlink -f ../TARA_ORFS)/
logs=$(readlink -f ../slurm_logs)/

mkdir -p ${out}/nt
mkdir -p ${out}/ptn

cd ${inreads}

for f in $(ls *.fa );do
echo $f
sbatch -c 18 -p hugemem,himem,blade -o ${logs}metagenmark${f}.%j.out << EOF
#!/bin/bash
~/myproject/MetaGeneMark_linux_64/mgm/./gmhmmp -f G -a -d -m  ~/myproject/MetaGeneMark_linux_64/mgm/MetaGeneMark_v1.mod $f -D ${out}/nt/$f.fna -A ${out}/ptn/$f.faa
EOF
done

