# UKbiobank-feature-selection-for-Adverse-drug-reaction

  Using Genome wide association analysis approach to feature selection (selection of SNPs to be involved in the ML model). We have two different sets of UKBB data 

  **Step 1**: Apply population level filtering on the both the data sets. The population level filtering including 
                      1. Individual missingness - 15%
                      2. Genotype missingness - 2%
                      3. Hardy-Weinberg Equilibrium - p-value > 1e-8
                      4. MAF - 0.001 (common variant)
                      
