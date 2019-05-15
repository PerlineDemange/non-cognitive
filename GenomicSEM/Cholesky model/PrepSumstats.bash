#!/bin/bash
#SBATCH -t 0:30:00
#SBATCH -N 1 

cd $TMPDIR
#Copying data to scratch for a single node job. Make reading data faster. 
cp $HOME/CogNonCog/GSEM_with23andME/input/* . # copy content of dir in the current folder (. is telling current folder)

#load necessary modules 
module load R/3.4.3 

#Execute program located in current folder # no save to not save the environment and slave to run as few background processes as possible
{
  Rscript --no-save --slave PrepareDataSumstats.R
}
wait

#Copy output folder back from scratch
cp *.RData $HOME/CogNonCog/GSEM_with23andME/output/