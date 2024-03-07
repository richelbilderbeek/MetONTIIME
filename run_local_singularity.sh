#!/bin/bash

# Download a fresh config file
rm -f metontiime2.conf
wget https://raw.githubusercontent.com/MaestSi/MetONTIIME/master/metontiime2.conf

# Change the number of processors from 6 to 4
sed -i 's/ ? 6 : 1 }/ ? 4 : 1 }/' metontiime2.conf

# Change the memory use from 10 to 7 GB
sed -i 's/ 10.GB / 7.GB /' metontiime2.conf

# Change the executor from pbspro to local
sed -i "s/executor = 'pbspro'/executor = 'local'/" metontiime2.conf

work_dir="${PWD}/work_local_singularity"
echo "work_dir: ${work_dir}"

results_dir="${PWD}/results_local_singularity"
echo "results_dir: ${results_dir}"

db_sequence_fasta_filename="${PWD}/example_db_sequence.fasta"
echo "db_sequence_fasta_filename: ${db_sequence_fasta_filename}"

sample_metadata_tsv_filename="${PWD}/example_sample_metadata.tsv"
echo "sample_metadata_tsv_filename: ${sample_metadata_tsv_filename}"

# Run locally
nextflow -c metontiime2.conf run metontiime2.nf \
  --workDir="${work_dir}" \
  --resultsDir="${results_dir}" \
  --dbSequencesFasta="${db_sequence_fasta_filename}" \
  --sampleMetadata="${sample_metadata_tsv_filename}" \
  -profile singularity
