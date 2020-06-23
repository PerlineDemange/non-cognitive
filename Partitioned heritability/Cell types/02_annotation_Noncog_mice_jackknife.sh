#!/bin/bash
#SBATCH -t 03:00:00
#SBATCH -N 1

cd "$TMPDIR"

module load 2019
module load Python/2.7.15-foss-2019b

python /home/vubiopsy/GWAS/resources/software/ldsc/ldsc.py \
--h2 /home/pdemange/CogNonCog/Annotations/Sumstats/NonCog_23andMe.sumstats.gz \
--ref-ld-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_baselineLD_v2.2/baselineLD.,/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/UNIONS/MouseAtlas.union.,/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/__ANNOT__. \
--w-ld-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_frq/1000G.EUR.QC. \
--out /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2_jackknife/NonCog/NonCog.__ANNOT__ \
--print-coefficients \
--print-delete-vals

echo "DONE" 
