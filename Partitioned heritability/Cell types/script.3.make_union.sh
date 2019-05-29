#!/bin/bash
#SBATCH -t 5:00:00
#SBATCH -N 1

cd "$TMPDIR"

module load python/2.7.9
module load R

Rscript --no-save --slave /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/Scripts/script.3.make_union.R

for CHR in $(seq 1 22);do
{
python /home/vubiopsy/GWAS/resources/software/ldsc/ldsc.py --l2 \
--bfile /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_EUR_Phase3_plink/1000G.EUR.QC.${CHR} \
--ld-wind-cm 1 \
--annot /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/UNIONS/MouseAtlas.union.${CHR}.annot.gz \
--out /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/UNIONS/MouseAtlas.union.${CHR} \
--print-snps /home/pdemange/CogNonCog/Annotations/LDScores_base_files/listHM3.txt
}
done
wait

echo "DONE"
