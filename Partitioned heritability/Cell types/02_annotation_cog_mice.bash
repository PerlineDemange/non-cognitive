#!/bin/bash
#SBATCH -t 10:00:00
#SBATCH -N 1


cd "$TMPDIR"

module load python/2.7.9

{
python /home/vubiopsy/GWAS/resources/software/ldsc/ldsc.py --h2 /home/pdemange/CogNonCog/Annotations/Sumstats/Cog_with23andMe.sumstats.gz \
--ref-ld-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_baselineLD_v2.2/baselineLD.,/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/UNIONS/MouseAtlas.union.,/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/${ANNOT}. \
--w-ld-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_frq/1000G.EUR.QC. \
--out /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2/Cog/Cog.${ANNOT} \
--print-coefficients
} & {
python /home/vubiopsy/GWAS/resources/software/ldsc/ldsc.py --h2 /home/pdemange/CogNonCog/Annotations/Sumstats/Cog.sumstats.gz \
--ref-ld-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_baselineLD_v2.2/baselineLD.,/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/${ANNOT}. \
--w-ld-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_weights_hm3_no_MHC/weights.hm3_noMHC. \
--overlap-annot \
--frqfile-chr /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_frq/1000G.EUR.QC. \
--out /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2/Cog/Cog.${ANNOT}.NO_UNION \
--print-coefficients
}

wait
echo "DONE"


