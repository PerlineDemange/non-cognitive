#Choose which set of gene sets to analyze. Options include Multi_tissue_gene_expr, Multi_tissue_chromatin, GTEx_brain, Cahoy, ImmGen, or Corces_ATAC
cts_name=Multi_tissue_gene_expr

#Download the LD scores
wget https://data.broadinstitute.org/alkesgroup/LDSCORE/LDSC_SEG_ldscores/${cts_name}_1000Gv3_ldscores.tgz
wget https://data.broadinstitute.org/alkesgroup/LDSCORE/1000G_Phase3_baseline_ldscores.tgz
wget https://data.broadinstitute.org/alkesgroup/LDSCORE/weights_hm3_no_hla.tgz
tar -xvzf ${cts_name}_1000Gv3_ldscores.tgz
tar -xvzf 1000G_Phase3_baseline_ldscores.tgz
tar -xvzf weights_hm3_no_hla.tgz

#Run the regression
ldsc/ldsc.py \
    --h2-cts NC.sumstats.gz \
    --ref-ld-chr 1000G_EUR_Phase3_baseline/baseline. \
    --out NC_${cts_name} \
    --ref-ld-chr-cts $cts_name.ldcts \
    --w-ld-chr weights_hm3_no_hla/weights.


ldsc/ldsc.py \
    --h2-cts C.sumstats.gz \
    --ref-ld-chr 1000G_EUR_Phase3_baseline/baseline. \
    --out C_${cts_name} \
    --ref-ld-chr-cts $cts_name.ldcts \
    --w-ld-chr weights_hm3_no_hla/weights.

