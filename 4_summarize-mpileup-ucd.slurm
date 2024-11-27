#!/bin/bash

#SBATCH --job-name=4_summarize-mpileup-ucd
#SBATCH --account <account>
#SBATCH --partition <partition>
#SBATCH --mail-type=END,FAIL
#SBATCH --mem=200G
#SBATCH --nodes=1
#SBATCH --cpus-per-task=10
#SBATCH --output=./logs/slurm-R-job-%J.stdout
#SBATCH --error=./logs/slurm-R-job-%J.stderr

singularity --version

sifdir=/opt/apps/containers/community/ACC
sif=${sifdir}/dcibioinformaticsR-v2.3.sif
wd=/hpc/group/chsi/RhCMV
  
singularity exec \
  --no-home \
  --containall \
  --bind ${wd}:${wd}:rw \
  ${sif} \
  Rscript ${wd}/Code/4_summarize-mpileup-ucd.R
