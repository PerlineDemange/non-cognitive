#!/bin/bash
#SBATCH -t 02:00:00
#SBATCH -N 1

# this script is used to do the MAGMA gene-set analysis 

# Specify files # careful no space can be allowed before or after the = sign 
SETDIR=/home/pdemange/CogNonCog/Annotations/MAGMA
SETFILE=geneset_top10expression.txt

GENERESULTSDIR=/home/pdemange/CogNonCog/Annotations/MAGMA/Genes_analysis/NonCog 
GENERESULTS=gene_analysis_allchr


	
# Specify output directory
OUTDIR=/home/pdemange/CogNonCog/Annotations/MAGMA/Gene_set_analysis/NonCog


echo start of job

################################
# Copy files and prepare for analysis
cd $TMPDIR

# copy genotype data
cp ${GENERESULTSDIR}/${GENERESULTS}.genes.raw .

echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "GENE ANALYSIS RESULT HAS BEEN COPIED"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"

# copy sumstats files
cp ${SETDIR}/${SETFILE} .

echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "GENE SET FILE HAS BEEN COPIED"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"



echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "STARTING GENE-SET ANALYSIS"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"


	

/home/pdemange/CogNonCog/Annotations/MAGMA/magma \
	--model self-contained \
	--gene-results ${GENERESULTS}.genes.raw \
	--set-annot ${SETFILE} \
	--out gene_set_analysis 
	



#echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
#echo "SAVE OUTPUT"
#echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
cp $TMPDIR/gene_set_analysis.* $OUTDIR

echo end of job
