#!/bin/bash
#SBATCH -t 1:00:00
#SBATCH -N 1

cd "$TMPDIR"

module load R
module load python/2.7.9

Rscript --no-save --slave /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/Scripts/script.2.input_2_annot.R ${i} ${ANNOT}
wait

for CHR in $(seq 1 22);do
python /home/vubiopsy/GWAS/resources/software/ldsc/ldsc.py --l2 \
--bfile /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_EUR_Phase3_plink/1000G.EUR.QC.${CHR} \
--ld-wind-cm 1 \
--annot /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/${ANNOT}.${CHR}.annot.gz \
--out /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/${ANNOT}.${CHR} \
--print-snps /home/pdemange/CogNonCog/Annotations/LDScores_base_files/listHM3.txt
done
wait

echo "DONE"
