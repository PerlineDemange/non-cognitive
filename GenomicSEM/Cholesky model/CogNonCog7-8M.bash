#!/bin/bash
#SBATCH -t 35:00:00
#SBATCH -N 1



cd $TMPDIR
#Copying data to scratch for a single node job. Make reading data faster. 
cp $HOME/CogNonCog/GSEM_with23andME/input/* . # copy content of dir in the current folder (. is telling current folder)

#load necessary modules 
module load R/3.4.3 

#Execute program located in current folder # no save to not save the envrionment and slave to run as few background processes as possible
{
  Rscript --no-save --slave CogNonCog2.R 6000001 7000000 cognitive7m noncog7m 1000
}&{
  Rscript --no-save --slave CogNonCog2.R 7000001 7311269 cognitive8m noncog8m 1000
}
wait

#Copy output folder back from scratch
cp *.Rda $HOME/CogNonCog/GSEM_with23andME/output/