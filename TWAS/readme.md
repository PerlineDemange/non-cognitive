# Transcriptome wide analysis study to investigate the enrichment of gene expression in the brain 

We used Gusev et al. FUSION software: http://gusevlab.org/projects/fusion/

We used precomputed brain gene expression weights available on the FUSION website: https://data.broadinstitute.org/alkesgroup/FUSION/WGT/CMC.BRAIN.RNASEQ.tar.bz2


We followed the detailed guidelines from the FUSION website. We run the TWAS on the cluster computer with the script: `TWAS_brain_noncog.bash` (identical procedure for Cog). 

We merged the results (chunked per chromosomes) with `combine_chr_files.txt`. As recommended by Gusev et al. we do not include the MHC region of chromosome 6 in our final results. 

Supplementary Figure 8 was created with `Twas_comparison.R`. 
