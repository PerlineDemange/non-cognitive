#!/bin/bash
#SBATCH -t 02:00:00
#SBATCH -N 1



# Specify geneloc files
GENELOCDIR=/home/pdemange/CogNonCog/Annotations/MAGMA
GENELOC=Geneloc_duplicated_excluded.txt

# Specify Snp loc file # To Specify in function 
#SNPLOCDIR= /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_baselineLD_v2.2/

# Specify output directory
OUTDIR=/home/pdemange/CogNonCog/Annotations/MAGMA/Annotations

# specify window size directly in function


echo start of job

################################
# Copy files and prepare for analysis
cd $TMPDIR

cp ${GENELOCDIR}/${GENELOC} .
cp /home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_baselineLD_v2.2/*.annot.gz . 



################################
# Annotate SNPs to genes
# The window size is in kilobase


for CHR in $(seq 1 22);do
	(
	# necessary steps to be able to use the baseline files from Finucane as reference for SNP location
	gunzip baselineLD.${CHR}.annot.gz
	awk '{print $3 " " $1 " " $2}' baselineLD.${CHR}.annot > current.txt #change the order of the columns so that Magma can recognize them 

	/home/pdemange/CogNonCog/Annotations/MAGMA/magma \
	--annotate window=10 \
	--snp-loc current.txt	\
	--gene-loc ${GENELOC} \
	--out snp_gene.${CHR}
	
	) 
done
wait

cp $TMPDIR/snp_gene.* $OUTDIR


echo end of job
