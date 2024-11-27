# Rename and index sample bams

###--------------------------------###
# Set up compute environment

# Start container with samtools
sifdir=/opt/apps/containers/community/ACC
sif=${sifdir}/dcibioinformaticsHTS-v0.9.sif
wd=/hpc/group/chsi/RhCMV
singularity shell \
  --no-home \
  --containall \
  --app samtools \
  --bind ${wd}:${wd}:rw \
  ${sif}

  
###--------------------------------###
# Paths

wd=/hpc/group/chsi/RhCMV

### VID ------------------------------------------------###

currRef=VID965_as_mapping_reference_mixing_experiment
bamDir=${wd}/Data/CLC/outputs/${currRef}/mapping

###--------------------------------###
# Rename BAMs to remove spaces

cd $bamDir
for f in *.bam; do
    mv -- "$f" "${f// /}"
done

###--------------------------------###
# Rename BAMs to standardize reference prefix
#vid965-genbank_read_mapping_<sampleid>(paired).bam

for f in *vid965*; do
  mv "$f" "${f//vid965/vid965-genbank}"
done


###--------------------------------###
# Index bams

bams=($(ls $bamDir))
echo "${bams[@]:0:1}"
cd $bamDir
for v in ${bams[@]}; do
  samtools index --bai ${v}
done



### UCD ------------------------------------------------###

currRef=UCD52_as_mapping_reference_mixing_experiment
bamDir=${wd}/Data/CLC/outputs/${currRef}/mapping

###--------------------------------###
# Rename BAMs to remove spaces

cd $bamDir
for f in *.bam; do
    mv -- "$f" "${f// /}"
done

###--------------------------------###
# Rename BAMs to standardize reference prefix
#vid965-genbank_read_mapping_<sampleid>(paired).bam

for f in *ucd52*; do
  mv "$f" "${f//ucd52/ucd52-genbank}"
done


###--------------------------------###
# Index bams

bams=($(ls $bamDir))
echo "${bams[@]:0:1}"
cd $bamDir
for v in ${bams[@]}; do
  samtools index --bai ${v}
done

