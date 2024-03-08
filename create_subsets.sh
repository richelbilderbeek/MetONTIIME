#!/bin/bash
#
# Even though the file has the '.gz' extension, it is not zipped.

head -n 12 Zymo-GridION-EVEN-BB-SN_sup_pass_filtered_27F_1492Rw_1000_reads.fastq.gz > example_1.fastq
tail -n 12 Zymo-GridION-EVEN-BB-SN_sup_pass_filtered_27F_1492Rw_1000_reads.fastq.gz > example_2.fastq
gzip example_1.fastq
gzip example_2.fastq
