#!/bin/bash
#SBATCH -t 02:00:00
#SBATCH -N 1

cd $TMPDIR

for CHR in $(seq 1 22);do
	(
Rscript /home/pdemange/TWAS/fusion_twas-master/FUSION.assoc_test.R \
--sumstats /home/pdemange/CogNonCog/Annotations/Sumstats/NonCog_23andMe_woblanks.sumstats \
--weights /home/pdemange/CogNonCog/Annotations/TWAS/WEIGHTS/CMC.BRAIN.RNASEQ.pos \
--weights_dir /home/pdemange/CogNonCog/Annotations/TWAS/WEIGHTS/ \
--ref_ld_chr /home/pdemange/TWAS/LDREF/1000G.EUR. \
--chr ${CHR} \
--out TWAS.Brain.NonCog.${CHR}
	
	) 
done
wait

cp TWAS.Brain.NonCog.* /home/pdemange/CogNonCog/Annotations/TWAS/Results_Brain

