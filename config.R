# config for RhCMV code

# Containers #----------------------------#

sifHTS <- "/opt/apps/containers/community/ACC/dcibioinformaticsHTS-v0.9.sif"
sifR <- "/opt/apps/containers/community/ACC/dcibioinformaticsR-v2.3.sif"
# also copied to RhCMV/Containers/
# def files are in RhCMV/Code/Container-defs


# Directories #----------------------------#

wd <- "/hpc/group/chsi/RhCMV"
procdir <- file.path(wd,"Proc")


# Annotation #----------------------------#

# VID965-FL(GCA_027929765.1)
vidref.fna <- file.path(wd, "Annotation/GCA_027929765.1_ASM2792976v1_genomic.fna")

# UCD52 (GCA_027930255.1)
ucdref.fna <- file.path(wd, "Annotation/GCA_027930255.1_ASM2793025v1_genomic.fna")


# Data inputs #----------------------------#

# Bams of samples aligned to each reference strain:

# VID965-FL(GCA_027929765.1)
vidref.dirname <- "MT157327FL_Genbank_as_mapping_reference"
vidref.bamDir <- file.path(wd, "Data/CLC/outputs", vidref.dirname, "mapping")

# UCD52 (GCA_027930255.1)
ucdref.dirname <- "MT157330-UCD52_Genbank_as_mapping_reference"
ucdref.bamDir <- file.path(wd, "Data/CLC/outputs", ucdref.dirname, "mapping")


# Intermediates #----------------------------#

procdir.1mpileup <- file.path(procdir, "1_get-bam-coverage-mpileup")
# {strainref}-genbank_read_mapping_{sampleid}_mpileup.tsv

procdir.2nucdiff <- file.path(procdir, "2_nucdiff/results")
# nucdiff_{alignment}_*
# ... where alignment "Q_VID_R_UCD" = query VID and reference UCD
# ... nucdiff output documentation: https://github.com/uio-cels/NucDiff/wiki#output-files

procdir.3mismatches <- file.path(procdir, "3_get-mismatches")
# windf_{alignment}.RDS

procdir.4summpileup <- file.path(procdir, "4_summarize-mpileup")
# basesumm-lst-{strainref}-n14.RDS
# mpilelst-{strainref}-n14.RDS

procdir.5fractiondfs <- file.path(procdir, "5_prep-fractionDFs")

procdir.6filtsnvs <- file.path(procdir, "6_filtering-SNVs")

procdir.7results <- file.path(procdir, "7_results")


# Resulting tables and figures #----------------------------#

resultdir <- file.path(wd, "Results")


