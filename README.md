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
  
  
  **Step 3**: Identify the independent variant using the plink pruning function

          plink --bfile ukb_complete_final 
                --keep-allele-order 
                --indep-pairwise 50 5 0.2 
                --out ukb_complete_indep
        
