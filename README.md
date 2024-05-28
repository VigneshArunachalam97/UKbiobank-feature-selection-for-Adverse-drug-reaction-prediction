# UKbiobank-feature-selection-for-Adverse-drug-reaction

  Using a **Genome-wide association analysis (GWAS)** approach to feature selection (**selection of SNPs to be involved in the ML model**). We have two different sets of UKBB data 

  **Step 1**: Apply population-level filtering on both data sets. The population level filtering including 
          
            1. Individual missingness (--mind) - 15%
            2. Genotype missingness (--geno) - 2%
            3. Hardy-Weinberg Equilibrium (--hew) - p-value > 1e-8
            4. Minor Allele Frequency (--maf) - 0.001 (common variant)
                      
