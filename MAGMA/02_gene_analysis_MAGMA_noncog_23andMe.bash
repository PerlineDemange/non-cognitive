#!/bin/bash
#SBATCH -t 02:00:00
#SBATCH -N 1

# this script is used to do the MAGMA gene analysis 

# Specify files # careful no space can be allowed before or after the = sign 
ANNOTDIR=/home/pdemange/CogNonCog/Annotations/MAGMA/Annotations
# !!!! need to change the name of the file and directory in the cp function 

SUMSTATSDIR=/home/pdemange/CogNonCog/Annotations/MAGMA
SUMSTATS=Non_Cognitive_GWAS_short_with23andMe.txt

REFDATADIR=/home/pdemange/CogNonCog/Annotations/MAGMA/Reference_data
REFDATA=g1000_eur # name of plink files (without extention) that will be used as reference data
	
# Specify output directory
OUTDIR=/home/pdemange/CogNonCog/Annotations/MAGMA/Genes_analysis/NonCog

# Specify columns names of sumstats file and sample size of the GWAS
SNP=SNP
PVAL=P	
N=623530



echo start of job

################################
# Copy files and prepare for analysis
cd $TMPDIR

# copy genotype data
cp ${REFDATADIR}/${REFDATA}.bed .
cp ${REFDATADIR}/${REFDATA}.bim .
cp ${REFDATADIR}/${REFDATA}.fam .
cp ${REFDATADIR}/${REFDATA}.synonyms .

echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "GENOTYPE DATA HAS BEEN COPIED"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"

# copy sumstats files
cp ${SUMSTATSDIR}/${SUMSTATS} .

echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "SUMSTATS FILES HAVE BEEN COPIED"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"

# copy annotation files from previous step 
cp /home/pdemange/CogNonCog/Annotations/MAGMA/Annotations/*.genes.annot . 

echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "ANNOTATION FILES HAVE BEEN COPIED"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"


echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
echo "STARTING GENE-BASED ANALYSIS"
echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"


	
for CHR in $(seq 1 22);do
	(
	/home/pdemange/CogNonCog/Annotations/MAGMA/magma \
	--bfile ${REFDATA} \
	--gene-annot snp_gene.${CHR}.genes.annot \
	--pval ${SUMSTATS} N=${N}  use=${SNP},${PVAL} \
	--out gene_analysis.batch${CHR}_chr 
	
	) 
done
wait

#echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
#echo "SAVE OUTPUT"
#echo "# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #"
cp $TMPDIR/gene_analysis.* $OUTDIR

echo end of job
