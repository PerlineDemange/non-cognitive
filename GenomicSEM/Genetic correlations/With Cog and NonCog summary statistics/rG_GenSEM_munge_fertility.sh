#!/bin/bash
#SBATCH -t 02:00:00
#SBATCH -N 1

# Run the munge function to prepare sumstats for genetic correlations with Genomic SEM 

cd $TMPDIR
#Copying data to scratch for a single node job. Make reading data faster. 
cp -r $HOME/CogNonCog/Genetic_Correlations/Sumstats/Sumstats_correct/* . # copy content of dir in the current folder (. is telling current folder)
cp -r $HOME/CogNonCog/Genetic_Correlations/Input/* .

#load necessary modules 
module load R/3.4.3 

#Execute program located in current folder # no save to not save the environment and slave to run as few background processes as possible
Rscript --no-save --slave Gene_cor_GenSEM_LISA_munge.R "sumstats_fertility.csv" gencor_fertility


#Copy output folder back from scratch
cp *.sumstats.gz $HOME/CogNonCog/Genetic_Correlations/Output_munge/ 
cp *.Rda $HOME/CogNonCog/Genetic_Correlations/Output_munge/ 