#!/bin/bash

# Download a fresh config file
rm -f metontiime2.conf
wget https://raw.githubusercontent.com/MaestSi/MetONTIIME/master/metontiime2.conf

# Change the number of processors to 4
sed -i 's/ ? 6 : 1 }/ ? 4 : 1 }/' metontiime2.conf

# Run locally
nextflow -c metontiime2.conf run metontiime2.nf \
  --workDir=${PWD} \
  --resultsDir="${PWD}/results_local_docker" \
  -profile docker 



