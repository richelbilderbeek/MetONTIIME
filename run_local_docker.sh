#!/bin/bash

# Download a fresh config file
rm -f metontiime2.conf
wget https://raw.githubusercontent.com/MaestSi/MetONTIIME/master/metontiime2.conf

# Change the number of processors from 6 to 4
sed -i 's/ ? 6 : 1 }/ ? 4 : 1 }/' metontiime2.conf

# Change the memory use from 10 to 7 GB
sed -i 's/ 10.GB / 7.GB /' metontiime2.conf

# Need to decrease the sampling depth
# https://forum.qiime2.org/t/plugin-error-from-diversity-ordinations/19588

work_dir="${PWD}/work_local_docker"
echo "work_dir: ${work_dir}"

# Get the example sequence in the correct folder 
mkdir "${work_dir}"
cp example_reads.fastq.gz "${work_dir}"

results_dir="${PWD}/results_local_docker"
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
  -profile docker 

exit 42

: <<'END_COMMENT'

  There was an issue with loading the file /home/richel/GitHubs/MetONTIIME/example_sample_metadata.tsv as metadata:
  
    Found unrecognized ID column name 'SH0985654.09FU_KY231246_reps' while searching for header. The first column name in the header defines the ID column, and must be one of these values:
  
    Case-insensitive: 'feature id', 'feature-id', 'featureid', 'id', 'sample id', 'sample-id', 'sampleid'
  
    Case-sensitive: '#OTU ID', '#OTUID', '#Sample ID', '#SampleID', 'sample_name'
  
    NOTE: Metadata files must contain tab-separated values.
  
    There may be more errors present in the metadata file. To get a full report, sample/feature metadata files can be validated with Keemei: https://keemei.qiime2.org
  
    Find details on QIIME 2 metadata requirements here: https://docs.qiime2.org/2023.9/tutorials/metadata/

Work dir:
  /home/richel/GitHubs/MetONTIIME/work/22/b4e5a41ca15629929de92a192221d0

Tip: view the complete command output by changing to the process work dir and entering the command `cat .command.out`

END_COMMENT


: <<'END_COMMENT'

The file example_sample_metadata.tsv was copied from 
noheader_taxonomy_qiime_ver9_dynamic_alleukaryotes_25.07.2023.tsv

However, the original file lacks a header!

To fix this: add as a first line:

feature id	taxon

there must be a tab between `feature id` and `taxon` (and between `feature` and `id` must be a space)

END_COMMENT


