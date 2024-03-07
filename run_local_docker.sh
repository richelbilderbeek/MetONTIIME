#!/bin/bash
wget -O https://raw.githubusercontent.com/MaestSi/MetONTIIME/master/metontiime2.conf
sed -i 's/ ? 6 : 1 }/ ? 4 : 1 }/' metontiime2.conf

nextflow -c metontiime2.conf run metontiime2.nf \
  --workDir=${PWD} \
  --resultsDir="${PWD}/results_local_docker" \
  -profile docker 



