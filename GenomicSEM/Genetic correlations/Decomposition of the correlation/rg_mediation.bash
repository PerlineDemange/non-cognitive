#!/bin/bash
#SBATCH -t 10:00:00
#SBATCH -N 1

# Run genetic correlation with genomic SEM 

cd $TMPDIR
#Copying data to scratch for a single node job. Make reading data faster. 
cp -r $HOME/CogNonCog/Genetic_Correlations/Mediation/Input* .
cp -r $HOME/CogNonCog/Genetic_Correlations/Output_munge/* .

#load necessary modules 
module load R/3.4.3 

#Execute program located in current folder # no save to not save the environment and slave to run as few background processes as possible
Rscript --no-save --slave run_rg_mediation.R "rG_alltraits_13082019.csv" gencor_all1308_mediation "gencor_all1308_mediation.Rda"



#Copy output folder back from scratch
cp *.Rda $HOME/CogNonCog/Genetic_Correlations/Mediation/Output/ 
cp *.csv $HOME/CogNonCog/Genetic_Correlations/Mediation/Output/ 