# Scripts used to estimate the heritability enrichment of genes specifically epxressed in nervous system cell-types. 

## To create the annotations 

Normalize_cell_expression.R: normalizing the expression within cell type, data from Zeisel et al.2018
script.0.submit_jobs.sh: 
script.1.input_2_annot.sh: 
script.2.input_2_annot.R: 
script.3.make_union.sh:
script.3.make_union.R: 
make.LDSR.annot_v2_4_6.R:  


## Estimate the partitioned heritability

01_Annotation_ldsc_script_munge.bash: Munge the sumstats to be able to use with LDSC (not a job, just copy paste in LISA) 
02_annotation_Noncog_mice.sh and 02_annotation_cog_mice.sh: Run the analysis. jobs that are run with the help of the next file:
03_script_run_all-annotations.bash: script to run on LISA, and this will loop over to run the previous jobs over a list of annotations. 
04_create_results_file.bash: Use the outputs of the previous files and combine them in one file per trait: the output is one line per annotation. The output used is on the format Cog.*.results (we do not use the output created without the union annotation "Cog.*.NO_UNION.results").  (I copy paste the lines directly in LISA)  
