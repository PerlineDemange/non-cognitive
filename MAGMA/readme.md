Scripts necessary for MAGMA geneset analysis

00_correct_gene_location_file.R
			input: GenCode v19 given by Hill
			output: Geneloc_duplicated_excluded.txt 
			This file corrects the GenCode file, where it appears that some genes are duplicated (with different location and chromosme position)
			The file removes all duplicated genes (any versions of these genes) and 
01_annotation_snp_gene_window.bash: 
			inputs: Geneloc_duplicated_excluded.txt, snploc=baselineLD_v2.2 (to be comparable with LDSC annotation, includes SNP location of 1000G phase3)
			output: in MAGMA/Annotations/ 
			The file annotates each SNP to a gene. As the snp location file is divided per chromosome, the whole analysis is divided per chromosome. Adds a window around the genes. 
02_gene_analysis_MAGMA_cog.bash/02_gene_analysis_MAGMA_noncog.bash
			input: output of 01, Cognitive_GWAS_short_New.txt/Non_Cognitive_GWAS_short_New.txt, g1000_eur reference genome data
			output: in MAGMA/Genes_analysis/Cog (or NonCog) .out is nice readable output and .genes.raw is to use in the gene-set analysis 
			Realises the gene analysis: quantify the degree of association between the genes and the phenotype
03_merge_gene_analysis_results.txt
			Use the merge function in MAGMA to combine the per chromosome .raw results in one file 
00_create_top10expressedgenes_MAGMA.R
			input: HOM_MouseHumanSequence.gencode_v19.list: dictionary mice genes to human genes, Mouseatlas_specific_expression_L5.txt: normalized across cell genes expression from Zeisel et al. (normalised by Michel)
			output: geneset_top10expression.txt
			Create the gene sets: Each set is the 10% most expressed genes in the specific celltype. Data comes from mice so the genes names are changed to human names. 
04_gene_set_analysis_MAGMA_Cog.bash 
			input: output of 03  gene_analysis_allchr.genes.raw for Cog and NonCog separately, geneset_top10expression.txt
			output: in Gene_set_analysis/Cog or NonCog  
				gene_set_analysis.gsa.genes.out: results per genes 
				gene_set_analysis.gsa.out: results per sets for competitive model (output we are interested in) 
				gene_set_analysis.gsa.self.out: results for self-contained analysis 
				gene_set_analysis.gsa.sets.genes.out: results per genes for significant sets 
			Realises the gene-set analysis (Competitive: Competitive gene-set analysis tests whether the genes in a gene-set are more strongly 
				associated with the phenotype of interest than other genes. Also do self-contained analysis)
05_Explore_gene_set_results.R
