# UKbiobank-feature-selection-for-Adverse-drug-reaction

  Using a **Genome-wide association analysis (GWAS)** approach to feature selection (**selection of SNPs to be involved in the ML model**). We have two different sets of UKBB data 

  **Step 1**: Apply population-level filtering on both data sets. The population level filtering including 
          
            1. Individual missingness (--mind) - 15%
            2. Genotype missingness (--geno) - 2%
            3. Hardy-Weinberg Equilibrium (--hew) - p-value > 1e-8
            4. Minor Allele Frequency (--maf) - 0.001 (common variant)
                      
  **Step 2**: Merge the two sets using Plink
            
            wd="working directory"
            ls ${wd}/*.bim | sed -e 's/.bim//g' > ${wd}/merge_list
            plink --merge-list ${wd}/merge_list 
                  --keep-allele-order 
                  --make-bed 
                  --out ${wd}/ukb_complete_final 
                  --memory 250000
  
  **Step 3:** Find the common variant between the two datasets and keep the intersecting variants for further analysi

         Rscript common_variant.R ukb_complete_data1 ukb_complete_data2 ukb_2sets
         plink --bfile ukb_complete_final 
               --extract ukb_2sets_common_variants.txt 
               --keep-allele-order
               --make-bed
               --out ukb_complete_common_variant
  
  **Step 4**: Identify the independent variant using the plink pruning function

          plink --bfile ukb_complete_common_variant
                --keep-allele-order 
                --indep-pairwise 50 5 0.2 
                --out ukb_complete_indep
  
 **Step 5**: Calculate the heterozygosity for all individuals using the pruned variants and remove the samples from further analysis if the sample heterozygosity rate is not beyond the +/- 3Standard deviation of heterozygosity rate

         plink --bfile ukb_complete_common_variant
               --extract ukb_complete_indep.prune.in
               --keep-allele-order
               --het
               --out ukb_R_check
         Rscript Heterozysity_plot_filter.R ukb_R_check.het
         plink --bfile ukb_complete_common_variant
               --remove ukb_fail-het.txt
               --keep-allele-order
               --make-bed
               --out ukb_complete_common_variant_final
