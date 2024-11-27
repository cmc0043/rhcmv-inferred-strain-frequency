# CHSI RhCMV KH14


## Data

- Sequenced samples were pre-processed in CLC workbench and outputs, namely aligned bams, were provided in a shared Box folder (`/CMV P01 Research Team/Research Data/Genomics/CLC Genomics Workflow & Files/outputs/`). Sample VCFs were also provided but are not used in the current workflow


## Annotation

- The following NCBI reference strain genomes were used for read mapping and downstream processing

  - **UCD52**: Macacine betaherpesvirus 3 strain UCD52, complete genome, Genome assembly [GCA_027930255.1](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_027930255.1/), see `GCA_027930255.1_ASM2793025v1_genomic.fna`

ref=/hpc/group/chsi/RhCMV/Annotation/GCA_027929765.1_ASM2792976v1_genomic.fna
query=/hpc/group/chsi/RhCMV/Annotation/GCA_027930255.1_ASM2793025v1_genomic.fna

  - **VID965-FL**: Mutant Rhesus cytomegalovirus strain 68-1_FL, complete genome, Genome assembly [GCA_027929765.1](https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_027929765.1/), see `GCA_027929765.1_ASM2792976v1_genomic.fna`


## Code

- `data-transfer`: Code used to download sample bam files and NCBI reference genome assemblies to the DCC workspace

- `1_get-bam-depth.*`: Extract sample read depth

- `2_nucdiff.sh`: Find local differences between reference strains

- `3_get-mismatches.*`: Count local differences between references strains (see Step 2) in sliding windows

- `4_summarize-mpileup.*`: For each sample `mpileup` output (see Step 1), summarize the frequency of each base at each genome position

- `5_prep-fractionsDFs.Rmd`: Create a dataframe for each sample, mapped to each strain, that indicates strain frequency at each strain SNP. This is accomplished with the following steps:

  - Identify strain SNP positions from the set of local differences between reference strains (see Step 2). 
  - For each sample, extract the frequency of each base (see Step 4) at each strain SNP position. 
  - Recode the base frequency as the strain frequency based on the identifying the base that corresponds to the mapping reference strain at that SNP (see Step 2)

- `6_filtering-SNVs.Rmd`: Refine the strain SNP positions to remove strain-specific frequency biases. The criteria for refining the set of strain SNPs used across all samples are listed below. In addition within each sample, a position must have coverage of at least 100 reads for inclusion. 

  - Density of local differences (see Step 3)
  - Alternate strain inoculum coverage (see Step 1) 
  - Alternate strain inoculum frequency (see Step 5) 

- `7_results.Rmd`: Generate tables and figures described below.

  - Calculate the average strain frequencies across refined strain SNPs within each sample mapped to each strain. Export a summary table and plot (see Step 6)
  - For each sample mapped to each strain, plot strain frequencies at each refined strain SNP along with sample coverage (see Step 6)
  - Plot the location of the initial pool of strain SNP positions in the genome (see Step 2,5)
  - Plot strain SNP positions that were excluded based on filtering criteria to control strain bias (see Step 6)

  