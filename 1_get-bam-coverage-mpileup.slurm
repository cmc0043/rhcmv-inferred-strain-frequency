#!/bin/bash

#SBATCH --job-name=1_get-bam-coverage-mpileup
#SBATCH --account <account>
#SBATCH --partition <partition>
#SBATCH --mail-type=END,FAIL
#SBATCH --mem=100G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --time=3-00:00:00
#SBATCH --output=./logs/slurm-R-job-%J.stdout
#SBATCH --error=./logs/slurm-R-job-%J.stderr

singularity --version

sifdir=/opt/apps/containers/community/ACC
sif=${sifdir}/dcibioinformaticsHTS-v0.9.sif
wd=/hpc/group/chsi/RhCMV
  
singularity exec \
  --no-home \
  --containall \
  --app samtools \
  --bind ${wd}:${wd}:rw \
  ${sif} \
  ${wd}/Code/1_get-bam-coverage-mpileup.sh
