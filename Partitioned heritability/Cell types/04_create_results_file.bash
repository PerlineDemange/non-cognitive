##################################################
## Project: CogNonCog 2018 - Stratified LDSC 
## Script purpose: Script to extract the last line of the LDSC results files (estimates for our annotation of interest)
## Input are the output files of the 03_script_run_all_annotations_20181121.bash
## Outputs: Cog_collected_results.txt, NonCog_collected_results.txt
## Date: November 2018
## Author: Perline Demange 
##################################################


##	Create a loop over all .results
#go to a (preferably empty) working directory
cd /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2/Results

### Cog 
#copy all results files to the working directory
# . at the end of the line is necessary, says it is not directory 
cp /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2/Cog/*.results .
rm *NO_UNION.results

#get the header of the file and save it in the output-file
head -n1 <$(ls *.results | head -n1) | awk 'BEGIN{OFS="\t"};1' > Cog_collected_results.txt

#loop over all results-files
#tail -n1 gets the last line (L2_2)
#the awk-statement replaces the first column ($1) with the variable "i" (defined using -v i=${i})

for i in $(ls *.results | sed 's!.results!!g');do
tail -n1 ${i}.results | awk -v i=${i} 'BEGIN{OFS="\t"};{$1=i};1' >> Cog_collected_results.txt
done

rm *.results

### NonCog 
#copy all results files to the working directory
# . at the end of the line is necessary, says it is not directory 
cp /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2/NonCog/*.results .
rm *NO_UNION.results

#get the header of the file and save it in the output-file
head -n1 <$(ls *.results | head -n1) | awk 'BEGIN{OFS="\t"};1' > NonCog_collected_results.txt

#loop over all results-files
#tail -n1 gets the last line
#the awk-statement replaces the first column ($1) with the variable "i" (defined using -v i=${i})

for i in $(ls *.results | sed 's!.results!!g');do
tail -n1 ${i}.results | awk -v i=${i} 'BEGIN{OFS="\t"};{$1=i};1' >> NonCog_collected_results.txt
done

rm *.results

