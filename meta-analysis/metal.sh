# PERFORM META-ANALYSIS based on effect size and on test statistic

# Loading in the input files with results from the  participating samples 
# Note: Replication of Lee et al Eduyears GWAS, by meta-analysis publicly available sumstats and 23andMe sumstats 
# Phenotype is Education years 
# Perline Demange March 2019


# OPTIONS 
MINMAXFREQ ON
AVERAGEFREQ ON
GENOMICCONTROL OFF

# === DESCRIBE AND PROCESS THE FIRST  and Second INPUT FILE, with same format ===

MARKER  MarkerName
ALLELE  A1 A2
PVALUE  Pval
EFFECT  Beta
STDERR  SE
WEIGHT  N 
FREQ  EAF
	

PROCESS Lee_2018_GWAS_EA_excl23andMe_N.txt 
PROCESS education_23andMe_forMETAL_N.txt
	
OUTFILE meta_education_lee_23andMe .txt
./YOURFILE.sh > log.txt
	
MINWEIGHT 500000 
ANALYZE
