#!/bin/bash
args=commandArgs(trailingOnly=TRUE)
print(args)
##args1 - 1st bim file
##args2 - 2nd bim file
##args3 - output prefix

### import packages ####
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(data.table))

### import data ###
data1 <- fread(args[1])
data2 <- fread(args[2])

inter <- intersect(data1$V2, data2$V2)
print(length(inter))

writeLine(inter, paste0(args[3], "_common_variant.txt"))
