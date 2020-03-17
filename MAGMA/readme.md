# Gene and Gene-sets analysis in MAGMA 

More information on how to run MAGMA analyses on MAGMA's website: https://ctg.cncr.nl/software/magma

`00_correct_gene_location_file.R`: This file corrects the GeneCode file, where it appears that some genes are duplicated (with different location and chromosme position). The file removes all duplicated genes (any versions of these genes). 	

`01_annotation_snp_gene_window.bash:`: The file annotates each SNP to a gene. As the snp location file is divided per chromosome, the whole analysis is divided per chromosome. Adds a window around the genes.

`02_gene_analysis_MAGMA_cog.bash`/`02_gene_analysis_MAGMA_noncog.bash`: Runs the gene analysis: quantify the degree of association between the genes and the phenotype

`03_merge_gene_analysis_results.txt`: Use the merge function in MAGMA to combine the per chromosome .raw results in one file

`00_create_top10expressedgenes_MAGMA.R`: Create the gene sets: Each set consists in the genes in the top 10% most specfic expression for the cell-type. Data comes from mice so the genes names are changed to human genes names using the file HOM_MouseHumanSequence.gencode_v19.list
- *Mouseatlas_specific_expression_L5.txt: normalized across cell genes expression from Zeisel et al. (normalised by Michel)*
- output: geneset_top10expression.txt 

`04_gene_set_analysis_MAGMA_Cog.bash`: Run the gene-set analysis. This cript runs both competitive and self-contained analysis, we used the competitive gen-set analysis results (Competitive gene-set analysis tests whether the genes in a gene-set are more strongly associated with the phenotype of interest than other genes)

`05_Explore_gene_set_results.R`: Combine the Cog and NonCog results from MAGMA gene set analysis together and with the description of the annotations. 
Save MAGMA results in one txt file. 
Create a scatterplot plotting Beta Cog against NonCog. 
Compare geneset enrichment between Cog and NonCog. 
Compare genes enrichment between Cog and NonCog. 
Create a plot with all genesets associations z-scores by Taxonomy. 
