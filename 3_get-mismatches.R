
library(tidyverse)
library(Biostrings)

wd <- "/hpc/group/chsi/RhCMV"
procdir <- file.path(wd, "Proc")
nucdiff.dir <- file.path(procdir, "2_nucdiff", "results")
outdir <- file.path(procdir, "3_get-mismatches")

gff.cols <- c("seqid","source","type","start",
              "end","score","strand","phase","attributes")

windowsize <- 100

# - VID965-FL(GCA_027929765.1)
# - UCD52 (GCA_027930255.1)

fna.vid <- file.path(wd, "Annotation/GCA_027929765.1_ASM2792976v1_genomic.fna")
fna.ucd <- file.path(wd, "Annotation/GCA_027930255.1_ASM2793025v1_genomic.fna")
fastas <- c(fna.vid, fna.ucd)
names(fastas) <- c("R_VID_Q_UCD", "Q_VID_R_UCD")

for (i in 1:length(fastas)) {
  
  aln.type <- names(fastas[i])
  FNA.path <- fastas[i]
  
  # load nucdiff results
  gffpath <- file.path(nucdiff.dir, 
                       paste0("nucdiff_", aln.type, "_ref_snps.gff"))
  gfftab <- read_table(gffpath, 
                       skip = 3, 
                       col_names = gff.cols)
  
  # load reference fasta
  dna <- readDNAStringSet(FNA.path)
  npositions <- length(dna[[1]])
  
  # make windows and find mismatches
  windf <- data.frame()
  
  for (j in 1:npositions) {
    
    # get the current window
    curr.st <- j
    curr.end <- curr.st + windowsize
    
    # calculate number of mismatches
    nsnps <- gfftab %>%
      filter(start >= curr.st &
               end <= curr.end) %>%
      nrow()
    
    # save
    windf.new <- data.frame(start = curr.st, 
                            end = curr.end,
                            nsnps = nsnps)
    windf <- rbind(windf, windf.new)
    
  }
  
  nrow(windf)
  
  saveRDS(windf, file = file.path(outdir, paste0("windf_", aln.type, ".RDS")))
  
}

