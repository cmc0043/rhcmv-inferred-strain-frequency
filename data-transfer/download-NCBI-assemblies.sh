# Download NCBI genome assemblies
refdir=/hpc/group/chsi/RhCMV/Annotation
cd ${refdir}


#**UCD52**
#- Macacine betaherpesvirus 3 strain UCD52, complete genome
#- GenBank: MT157330.1, https://www.ncbi.nlm.nih.gov/nuccore/MT157330, manually downloaded `sequence_MT157330.1.gff3`
#- Genome assembly GCA_027930255.1, https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_027930255.1/

## Issues!
curl --output ncbi.zip https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_027929765.1/download?include_annotation_type=GENOME_FASTA&include_annotation_type=GENOME_GFF&include_annotation_type=RNA_FASTA&include_annotation_type=CDS_FASTA&include_annotation_type=PROT_FASTA&include_annotation_type=SEQUENCE_REPORT&hydrated=FULLY_HYDRATED
unzip ncbi.zip
# note that the curl command *only* downloaded the *.fna annotation file with the above command!
curl --output ncbi.zip https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_027929765.1/download?include_annotation_type=GENOME_GFF
unzip ncbi.zip
# note that there is no resulting data folder with this command!

## FASTA
curl --output ncbi.zip https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCA_027930255.1/download?include_annotation_type=GENOME_FASTA
unzip ncbi.zip
mv ncbi_dataset ncbi_dataset_GCA_027930255.1
rm *.zip

# legacy approach
curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/027/930/255/GCA_027930255.1_ASM2793025v1/GCA_027930255.1_ASM2793025v1_genomic.fna.gz
curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/027/930/255/GCA_027930255.1_ASM2793025v1/GCA_027930255.1_ASM2793025v1_genomic.gff.gz
curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/027/930/255/GCA_027930255.1_ASM2793025v1/GCA_027930255.1_ASM2793025v1_genomic.gtf.gz
gunzip GCA_027930255.1_ASM2793025v1_genomic.fna.gz


#**VID965-FL**
#- Mutant Rhesus cytomegalovirus strain 68-1_FL, complete genome
#- GenBank: MT157327.1, https://www.ncbi.nlm.nih.gov/nuccore/MT157327, manually downloaded `sequence_MT157327.1.gff3`
#- Genome assembly GCF_000844865.1, https://www.ncbi.nlm.nih.gov/datasets/genome/GCA_027929765.1/

## FASTA
curl --output ncbi.zip https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_000844865.1/download?include_annotation_type=GENOME_FASTA
unzip ncbi.zip
mv ncbi_dataset ncbi_dataset_GCF_000844865.1
rm *.zip
rm README.md

## GFF
curl --output ncbi.zip https://api.ncbi.nlm.nih.gov/datasets/v2alpha/genome/accession/GCF_000844865.1/download?include_annotation_type=GENOME_GFF
unzip ncbi.zip
mv ncbi_dataset/data/GCF_000844865.1/genomic.gff ncbi_dataset_GCF_000844865.1/data/GCF_000844865.1/
rm -r ncbi_dataset 
rm *.zip
rm README.md

# legacy approach
curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/027/929/765/GCA_027929765.1_ASM2792976v1/GCA_027929765.1_ASM2792976v1_genomic.fna.gz
curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/027/929/765/GCA_027929765.1_ASM2792976v1/GCA_027929765.1_ASM2792976v1_genomic.gff.gz
curl -O https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/027/929/765/GCA_027929765.1_ASM2792976v1/GCA_027929765.1_ASM2792976v1_genomic.gtf.gz
gunzip GCA_027929765.1_ASM2792976v1_genomic.fna.gz

