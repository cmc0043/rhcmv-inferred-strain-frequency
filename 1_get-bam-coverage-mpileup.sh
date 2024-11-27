#!/bin/bash

wd=/hpc/group/chsi/RhCMV
out=${wd}/Proc/1_get-bam-coverage-mpileup

# Samples aligned to ref = VID965-FL(GCA_027929765.1)
currRef=MT157327FL_Genbank_as_mapping_reference
bamDir=${wd}/Data/CLC/outputs/${currRef}/mapping
bams=($(ls $bamDir | grep -Ev '*.bam.bai$'))
cd $bamDir

for v in ${bams[@]}; do
  s="$(basename -- $v)"
  id="${s/'(paired).bam'/}"
  samtools mpileup ${v} \
  --min-BQ 20 \
  --max-depth 0 \
  --no-output-ends \
  --no-output-ins \
  --no-output-del \
  -o ${out}/${id}_mpileup.tsv
done


# Samples aligned to ref = UCD52 (GCA_027930255.1)
currRef=MT157330-UCD52_Genbank_as_mapping_reference
bamDir=${wd}/Data/CLC/outputs/${currRef}/mapping
bams=($(ls $bamDir | grep -Ev '*.bam.bai$'))
cd $bamDir

for v in ${bams[@]}; do
  s="$(basename -- $v)"
  id="${s/'(paired).bam'/}"
  samtools mpileup ${v} \
  --min-BQ 20 \
  --max-depth 0 \
  --no-output-ends \
  --no-output-ins \
  --no-output-del \
  -o ${out}/${id}_mpileup.tsv
done


# Mixing samples aligned to ref = VID965-FL(GCA_027929765.1)
currRef=VID965_as_mapping_reference_mixing_experiment
bamDir=${wd}/Data/CLC/outputs/${currRef}/mapping
bams=($(ls $bamDir | grep -Ev '*.bam.bai$'))
cd $bamDir

for v in ${bams[@]}; do
  s="$(basename -- $v)"
  id="${s/'(paired).bam'/}"
  samtools mpileup ${v} \
  --min-BQ 20 \
  --max-depth 0 \
  --no-output-ends \
  --no-output-ins \
  --no-output-del \
  -o ${out}/${id}_mpileup.tsv
done


# Mixing samples aligned to ref = UCD52 (GCA_027930255.1)
currRef=UCD52_as_mapping_reference_mixing_experiment
bamDir=${wd}/Data/CLC/outputs/${currRef}/mapping
bams=($(ls $bamDir | grep -Ev '*.bam.bai$'))
cd $bamDir

for v in ${bams[@]}; do
  s="$(basename -- $v)"
  id="${s/'(paired).bam'/}"
  samtools mpileup ${v} \
  --min-BQ 20 \
  --max-depth 0 \
  --no-output-ends \
  --no-output-ins \
  --no-output-del \
  -o ${out}/${id}_mpileup.tsv
done


