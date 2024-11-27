# R functions to select strain SNPs from NucDiff output

# Processing/Load nucdiff local differences and identify strain SNPs
get_strainSNPs <- function(gfftab){
  
  # select local differences with length 0
  # select substitutions
  gff.strainSNPs <- gfftab %>%
    mutate(length = end - start) %>%
    filter(length == 0,
           grepl("substitution", attributes))
  
  return(gff.strainSNPs)
  
}

load_select_SNPbases <- function(aln.type, procdir.2nucdiff, gff.cols){
  
  # load GFF
  gffpath <- file.path(procdir.2nucdiff, paste0("nucdiff_", aln.type, "_ref_snps.gff"))
  gfftab <- read_table(gffpath, skip = 3, col_names = gff.cols)
  
  # load VCF
  vcfpath <- file.path(procdir.2nucdiff, paste0("nucdiff_", aln.type, "_ref_snps.vcf"))
  vcftab <- read_table(vcfpath, skip = 2, col_names = TRUE)
  
  # select strain SNPs
  sSNPs <- gfftab %>%
    get_strainSNPs() %>%
    pull(start)
  sSNPbases <- vcftab %>%
    filter(POS %in% sSNPs)
  
  if(length(sSNPs) != nrow(sSNPbases)){
    print("Warning! Not all GFF SNPs were found in the VCF")
  }
  
  return(sSNPbases)
}