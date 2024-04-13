#!/bin/bash

# Define input and output files
index="hsapiens_index"
output_dir="salmon_output"

# List of input fastq files
input_files=("SRR12010559" "SRR12010560" "SRR12010561" "SRR12010565" "SRR12010566" "SRR12010567" "SRR12010571" "SRR12010572" "SRR12010573" "SRR12010577" "SRR12010578" "SRR12010579")

# Loop through each input fastq file
for input_fastq in "${input_files[@]}"; do
    # Run salmon quant command
    salmon quant -i "$index" -l A -1 "${input_fastq}_1.fastq" -2 "${input_fastq}_2.fastq" -o "${output_dir}/${input_fastq}" --validateMappings -p 8 --gcBias
done
