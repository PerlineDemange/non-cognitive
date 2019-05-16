#!/bin/bash
#SBATCH -t 35:00:00
#SBATCH -N 1

echo time 

cd $TMPDIR
#Copying data to scratch for a single node job. Make reading data faster. 
cp $HOME/CogNonCog/GSEM_with23andME/input/* . # copy content of dir in the current folder (. is telling current folder)

#load necessary modules 
module load R/3.4.3 

#Execute program located in current folder # no save to not save the envrionment and slave to run as few background processes as possible
{
  Rscript --no-save --slave CogNonCog2.R 2000001 3000000 cognitive3m noncog3m 1000
}&{
  Rscript --no-save --slave CogNonCog2.R 3000001 4000000 cognitive4m noncog4m 1000
}
wait

#Copy output folder back from scratch
cp *.Rda $HOME/CogNonCog/GSEM_with23andME/output/

echo time