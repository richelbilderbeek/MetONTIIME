#!/bin/bash

#####################################
# Create a reproducible config file #
#####################################

# Download a fresh config file
rm -f metontiime2.conf
wget https://raw.githubusercontent.com/MaestSi/MetONTIIME/master/metontiime2.conf

# Change the number of processors from 6 to 4
sed -i 's/ ? 6 : 1 }/ ? 4 : 1 }/' metontiime2.conf

# Change the memory use from 10 to 7 GB
sed -i 's/ 10.GB / 7.GB /' metontiime2.conf

# Change the executor from pbspro to local
sed -i "s/executor = 'pbspro'/executor = 'local'/" metontiime2.conf

# Do not do a diversity analysis with one ?species
sed -i "s/diversityAnalyses = true/diversityAnalyses = false/" metontiime2.conf

# Set an overly-generous low identity for de novo clustering (it should be close to 1.0)
sed -i "s/clusteringIdentity=1/clusteringIdentity=0.1/" metontiime2.conf
	
# Set an overly-generous low minimum fraction of assignments to be accepted as consensus assignment (it should be close to 1.0)
sed -i "s/minConsensus=0.7/minConsensus=0.5/" metontiime2.conf

# Show the final config file
cat metontiime2.conf

#####################################
# Do the analysis                   #
#####################################

work_dir="${PWD}/work_local_singularity"
echo "work_dir: ${work_dir}"

# Get the example sequence in the correct folder 
mkdir "${work_dir}"
cp example_reads.fastq.gz "${work_dir}"

results_dir="${PWD}/results_local_singularity"
echo "results_dir: ${results_dir}"

db_sequence_fasta_filename="${PWD}/example_db_sequence.fasta"
echo "db_sequence_fasta_filename: ${db_sequence_fasta_filename}"

sample_metadata_tsv_filename="${work_dir}/created_sample_metadata.tsv"
# From Simone Maestri:
# > the sample metadata file is optional, 
# > you don't need to create one, you can specify the path to an empty file, 
# > which will be created upon running
# sample_metadata_tsv_filename="${PWD}/example_sample_metadata.tsv"
echo "sample_metadata_tsv_filename: ${sample_metadata_tsv_filename}"

taxonomy_tsv_filename="${PWD}/example_taxonomy.tsv"
echo "taxonomy_tsv_filename: ${taxonomy_tsv_filename}"

# Run locally
nextflow -c metontiime2.conf run metontiime2.nf \
  --workDir="${work_dir}" \
  --resultsDir="${results_dir}" \
  --dbSequencesFasta="${db_sequence_fasta_filename}" \
  --sampleMetadata="${sample_metadata_tsv_filename}" \
  --dbTaxonomyTsv="${taxonomy_tsv_filename}" \
  -profile singularity
