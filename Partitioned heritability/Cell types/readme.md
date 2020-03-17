# Heritability enrichment of genes specifically expressed in nervous system cell-types. 
More details on https://github.com/bulik/ldsc/wiki/Partitioned-Heritability

## Creation of the annotations 
These scripts were adapted from scripts by Hill Ip, and use the functions `make.LDSR.annot_v2_4_6.R`, available in https://github.com/hillfung/make_LDSR_annot. \
`Normalize_cell_expression.R`: normalizing the expression within cell type, data from Zeisel et al. 2018 \
`script.0.submit_jobs.sh`:  Run script.1.input_2_annot.sh for each cell types. \
`script.1.input_2_annot.sh`: Create an annotation for each cell type in each chromosome, using `script.2.input_2_annot.R.`\
`script.2.input_2_annot.R`:  Retain the 10% of genes most specific to a cell-type as the “cell-type specific” gene-set, get the corresponding human gene ID and use the function make.LDSR.annot() to create the corresponding annotations. We set no window and a gene shoulder of 10000bp.  \
`script.3.make_union.sh`: Create an union annotation for each chromosome, using `script.3.make_union.R`. \
`script.3.make_union.R`: Create unions: new annotation containing all SNPs that is part of at least one annotation, using the function collapse.annots().


## Estimation of the partitioned heritability

`01_Annotation_ldsc_script_munge.bash`: Munge the sumstats to be able to use with LDSC \
`02_annotation_Noncog_mice.sh` and `02_annotation_cog_mice.sh`: Run the partitioned heritability analysis. Jobs that are run for annotation with the help of the next file:\
`03_script_run_all-annotations.bash`: Run the previous scripts over a list of annotations. \
`04_create_results_file.bash`: Use the outputs of the previous files and combine them in one file per trait: the output is one line per annotation. We used the output created with the union annotation (we do not use the output created without the union annotation ".NO_UNION.results"). 



## Add 05_explore to create fig + final data
