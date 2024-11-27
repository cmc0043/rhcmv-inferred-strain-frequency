# utility functions

# Figure and table formating ------------------------------------------------

newlab <- function(lab, caption = ""){
  #' This takes an exiting label and adds 1. For example, input "Fig. 1" and return "Fig. 2".
  #' @param lab Label as a text string, e.g. "Fig. 1", where the numeric part can be split off based on the first appearance of a space, " ".
  #' @param caption Additional description behind the numeric part of the label, e.g. "Fig. 1 Caption"
  #' @return Text string that after adding 1 to the input lab
  type.text <- str_split(lab, " ")[[1]][1]
  curr.num <- as.numeric(str_split(lab, " ")[[1]][2])
  new.num <- curr.num + 1
  label <- paste0(type.text, " ", new.num, ". ", caption)
  
  # How to use this function to add figure/table numbers in your report:
  
  ## 1. Initialize the figure and table labels at the beginning of the report
  
  # figlab <- "Figure 0"
  # tablab <- "Table 0"
  
  ## 2. Create a new label iterate the label number like this...
  
  # figlab <- newlab(lab = figlab)
  # figlab # Figure 1.
  # figlab <- newlab(lab = figlab)
  # figlab # Figure 2.
  
  return(label)
}

simple.DT <- function(df, title = NULL) {
  
  # keep track of the numbers using newlab and pass the newlab to "title"
  # tblno <<- tblno + 1
  # 
  # if (!is.null(title)) {
  #   title <- glue("Table {tblno}. {title}")
  # } else {
  #   title <- glue("Table {tblno}.")
  # }
  
  num.colnames <- names(which(sapply(df, class) == "numeric"))
  num.idx <- which(colnames(df) %in% num.colnames)
  
  dim <- dim(df)
  if (!dim[1] > 10) {
    tab <- df %>%
      DT::datatable(caption = title,
                    rownames = FALSE,
                    options = list(dom = "t",
                                   scrollX = TRUE))
  } else {
    tab <- df %>%
      DT::datatable(caption = title,
                    rownames = FALSE,
                    options = list(scrollX = TRUE))
  }
  
  # suppress the printing to show tables in Rstudio
  # print(
  #   htmltools::tagList(
  #     DT::formatSignif(
  #       tab,
  #       digits = 2,
  #       columns = num.idx
  #     )
  #   )
  # )
  
  return(tab)
  
}

# Handle intermediates ------------------------------------------------

saveRDSobj <- function(cobj, cobjname = NULL, outdir = './', suffix = '', md5 = TRUE) {
  #' This function saves an R object as a serial object using base::saveRDS.
  #' The name of the output file is the {cobj}-{suffix}.RDS.
  #' @param cobj R object to be saved using saveRDS
  #' @param outdir Output directory
  #' @param suffix Suffix to be added to output file name
  #' @param md5 Boolean flag to calculate and return md5 sum
  #' @return md5 sum of output file if md5 == TRUE, NULL otherwise
  
  if(is.null(cobjname)){
    cobjname <- deparse(substitute(cobj))
    cobjname <- gsub("[.]","-", cobjname) # change "." to "-"
  }
  if(suffix == ''){
    fname <- file.path(outdir, paste0(cobjname,".RDS"))
  }else{
    fname <- file.path(outdir, paste0(cobjname,"-",suffix,".RDS"))
  }
  saveRDS(cobj, file = fname)
  if(md5) {
    tools::md5sum(fname)
  }
  
}

readRDSobj <- function(fdir, fname, md5 = TRUE) {
  #' This loads an R object that was saved as a serial object using base::saveRDS.
  #' @param fdir RDS file directory
  #' @param fname RDS filename
  #' @param md5 Boolean flag to calculate and return md5 sum
  #' @return md5 sum of output file if md5 == TRUE, NULL otherwise
  fname <- file.path(fdir, fname)
  out <- readRDS(fname)
  if(md5) {
    print(tools::md5sum(fname))
  }
  return(out)
}

