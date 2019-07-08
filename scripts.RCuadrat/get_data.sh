#!/bin/bash
while IFS='' read -r line || [[ -n "$line" ]]; do

sbatch -c 10 --mem=12gb -o sra.out << EOF
#!/bin/bash
module load sratoolkit

echo "Text read from file: $line"
    fastq-dump --gzip --split-files  $line
EOF
done < "$1"
