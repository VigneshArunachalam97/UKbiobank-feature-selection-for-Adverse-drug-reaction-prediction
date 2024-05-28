#!/bin/bash
args = commandArgs(trailingOnly=TRUE)
print(args)
print("args completed")
###args1 - heterofile file folder
###args2 - working directory
setwd(args[2])
print(getwd())
x <- list.files(pattern = ".het")
print(x)
for(i in 1:length(x)){
   y<-gsub("R_check.het", "", x[i])
   print(y)
   het <- read.table(x[i], head=TRUE)
   het$HET_RATE = (het$"N.NM." - het$"O.HOM.")/het$"N.NM."
   het_fail = subset(het, (het$HET_RATE < mean(het$HET_RATE)-3*sd(het$HET_RATE)) | (het$HET_RATE > mean(het$HET_RATE)+3*sd(het$HET_RATE)));
   het_fail$HET_DST = (het_fail$HET_RATE-mean(het$HET_RATE))/sd(het$HET_RATE)
   write.table(het_fail, quote = FALSE, sep = "\t", paste0(args[2], "/" ,y, "fail-het.txt"), row.names = F)
   print("Saved the heterozygosity outliers sample")
   head(het_fail)
   pdf(paste0(args[2],"/",y, "heterozygosity.pdf"))
   print(hist(het$HET_RATE, xlab="Heterozygosity Rate", ylab="Frequency", main= "Heterozygosity Rate"))
   dev.off()
   print(paste0(y, "completed"))
}
