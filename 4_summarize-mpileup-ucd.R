#!/usr/bin/Rscript

library(tidyverse)
library(data.table)

wd <- "/hpc/group/chsi/RhCMV"
procdir <- file.path(wd, "Proc")
bampileup.dir <- file.path(procdir, "1_get-bam-coverage-mpileup")

summarize_mpileup_bases <- function(mpiletab){
  
  basesumm.l <- list()
  for (i in 1:nrow(mpiletab)) {
    myrow <- mpiletab[i,]
    mybases <- str_split_1(myrow$read.base, "")
    basesumm.l[[i]] <- data.frame(table(toupper(mybases)))
  }
  names(basesumm.l) <- mpiletab$pos
  
  basesumm.df <- basesumm.l %>%
    purrr::map_dfr(~data.frame(.x), .id = "pos")
  
  return(basesumm.df)
  
}



## UCD ##---------------------------------------------------##
currfiles <- list.files(bampileup.dir,
                        full.names = TRUE,
                        pattern = "ucd52")
outfile1 <- file.path(procdir, "4_summarize-mpileup",
                      "mpilelst-ucd-n14.RDS")
outfile2 <- file.path(procdir, "4_summarize-mpileup",
                      "basesumm-lst-ucd-n14.RDS")
  
mpilelst <- list()
for (i in 1:length(currfiles)) {
  
  name <- str_split(basename(currfiles[i]), pattern = "_")[[1]][4]
  tab <- fread(
    currfiles[i],
    sep = "\t",
    col.names = c("chrom","pos","ref","count","read.base","base.qual")
  )
  mpilelst[[name]] <- tab
  
}

# saveRDS(mpilelst, file = outfile1)# don't need to save since this is massive
# and isn't used anywhere else in our scripts

basesumm.lst <- list()
for (i in 1:length(mpilelst)) {
  
  name <- names(mpilelst)[i]
  basesumm.df <- summarize_mpileup_bases(mpilelst[[i]])
  basesumm.lst[[name]] <- basesumm.df
  
}

saveRDS(basesumm.lst, file = outfile2)

