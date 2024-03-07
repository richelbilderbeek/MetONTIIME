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

# Run locally
nextflow -c metontiime2.conf run metontiime2.nf \
  --workDir=${PWD} \
  --resultsDir="${PWD}/results_local_singularity" \
  -profile singularity



