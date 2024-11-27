
# NOTE:
# had to create a tmp dir under /work/lwr11 to get the image to build...
# otherwise it will through an error about /work/lwr11/tmp not existing
wd=/hpc/group/chsi/RhCMV
tag=2.0.2--py_3
sif=docker://quay.io/biocontainers/nucdiff:${tag}
apptainer shell \
	--bind ${wd}:${wd}:rw \
  --bind ${tmp}:${tmp}:rw \
	${sif}

# - VID965-FL(GCA_027929765.1)
# - UCD52 (GCA_027930255.1)

out=/hpc/group/chsi/RhCMV/Proc/2_nucdiff
ref=/hpc/group/chsi/RhCMV/Annotation/GCA_027929765.1_ASM2792976v1_genomic.fna
query=/hpc/group/chsi/RhCMV/Annotation/GCA_027930255.1_ASM2793025v1_genomic.fna
prefix=nucdiff_R_VID_Q_UCD
nucdiff \
  --vcf yes \
  ${ref} \
  ${query} \
  ${out} \
  ${prefix}

query=/hpc/group/chsi/RhCMV/Annotation/GCA_027929765.1_ASM2792976v1_genomic.fna
ref=/hpc/group/chsi/RhCMV/Annotation/GCA_027930255.1_ASM2793025v1_genomic.fna
prefix=nucdiff_Q_VID_R_UCD
nucdiff \
  --vcf yes \
  ${ref} \
  ${query} \
  ${out} \
  ${prefix}
  
  
# nucdiff output documentation: https://github.com/uio-cels/NucDiff/wiki#output-files