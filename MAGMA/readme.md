# Gene and Gene-sets analysis in MAGMA 

More information on how to run MAGMA analyses on MAGMA's website: https://ctg.cncr.nl/software/magma

`00_correct_gene_location_file.R`: This file corrects the GeneCode file, where it appears that some genes are duplicated (with different location and chromosme position). The file removes all duplicated genes (any versions of these genes). 	

`01_annotation_snp_gene_window.bash:`: The file annotates each SNP to a gene. As the snp location file is divided per chromosome, the whole analysis is divided per chromosome. Adds a window around the genes.

`02_gene_analysis_MAGMA_cog_23andMe.bash`/`02_gene_analysis_MAGMA_noncog_23andMe.bash`: Runs the gene analysis: quantify the degree of association between the genes and the phenotype

`03_merge_gene_analysis_results.txt`: Use the merge function in MAGMA to combine the per chromosome .raw results in one file

`00_Normalize_cell_expression.R`: Normalize genes expression across cells, data from Zeisel et al. 2018
`00_create_top10expressedgenes_MAGMA.R`: Create the gene sets: Each set consists in the genes in the top 10% most specfic expression for the cell-type. Data comes from mice so the genes names are changed to human genes names using the file HOM_MouseHumanSequence.gencode_v19.list

`04_gene_set_analysis_MAGMA_Cog.bash`: Run the gene-set analysis. This cript runs both competitive and self-contained analysis, we used the competitive gen-set analysis results (Competitive gene-set analysis tests whether the genes in a gene-set are more strongly associated with the phenotype of interest than other genes)

`05_Explore_gene_set_results_23andMe.R`: Combine the Cog and NonCog results from MAGMA gene set analysis together and with the description of the annotations. 
Save MAGMA results in one txt file. Compare genes and geneset enrichment between Cog and NonCog. Create Sup. Figures 13 and 14. 
