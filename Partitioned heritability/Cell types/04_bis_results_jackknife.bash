##################################################
## Project: CogNonCog - Stratified LDSC - Jackknife revision
## Script purpose: Script to extract the last line of the LDSC results files (estimates for our annotation of interest)
## Outputs: Cog_collected_results_jackknife.txt, NonCog_collected_results_jackknife.txt
## Adapted from 04_create_results_file.bash
## Author: Perline Demange 
##################################################


##	Create a loop over all .results
#go to a (preferably empty) working directory
cd /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2_jackknife/Results

### Cog 
#copy all results files to the working directory
# . at the end of the line is necessary, says it is not directory 
cp /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2_jackknife/Cog/*.results .

#get the header of the file and save it in the output-file
head -n1 <$(ls *.results | head -n1) | awk 'BEGIN{OFS="\t"};1' > Cog_collected_results_jackknife.txt

#loop over all results-files
#tail -n1 gets the last line (L2_2)
#the awk-statement replaces the first column ($1) with the variable "i" (defined using -v i=${i})

for i in $(ls *.results | sed 's!.results!!g');do
tail -n1 ${i}.results | awk -v i=${i} 'BEGIN{OFS="\t"};{$1=i};1' >> Cog_collected_results_jackknife.txt
done

rm *.results

### NonCog 
#copy all results files to the working directory
# . at the end of the line is necessary, says it is not directory 
cp /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2_jackknife/NonCog/*.results .

#get the header of the file and save it in the output-file
head -n1 <$(ls *.results | head -n1) | awk 'BEGIN{OFS="\t"};1' > NonCog_collected_results_jackknife.txt

#loop over all results-files
#tail -n1 gets the last line
#the awk-statement replaces the first column ($1) with the variable "i" (defined using -v i=${i})

for i in $(ls *.results | sed 's!.results!!g');do
tail -n1 ${i}.results | awk -v i=${i} 'BEGIN{OFS="\t"};{$1=i};1' >> NonCog_collected_results_jackknife.txt
done

rm *.results

### Difference of the coefficientm with jackknife SE 

# bind NonCog and Cog jackknife estimates of the coefficient
j=0
for ANNOT in $(ls /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/*.1.annot.gz | sed 's!/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/!!g' | sed 's!.1.annot.gz!!g');do
j=$(( j + 1 ))
awk '{print $NF}'  /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2_jackknife/NonCog/NonCog.${ANNOT}.part_delete > noncog_jackknife_${ANNOT} 
awk '{print $NF}'  /home/pdemange/CogNonCog/Annotations/LDSC/shoulder10k_nowindow_baselineld2.2_jackknife/Cog/Cog.${ANNOT}.part_delete > cog_jackknife_${ANNOT} 
paste noncog_jackknife_${ANNOT} cog_jackknife_${ANNOT} > ${ANNOT}_Coef_jackknife.csv
sed -i '1i NonCog Cog' ${ANNOT}_Coef_jackknife.csv
done 

module load 2019
module load R 
R
library(stringr)

cog <- read.table("Cog_collected_results_jackknife.txt", header=T, stringsAsFactor=F) 
noncog <- read.table("NonCog_collected_results_jackknife.txt", header=T, stringsAsFactor=F) 
split <- unlist(strsplit(cog$Category, "\\.")) 
cols <- c("Type", "Annot")
nC <- length(cols)
ind <- seq(from=1, by=nC, length=nrow(cog))
for(i in 1:nC) {
  cog[, cols[i]] <- split[ind + i - 1]
}
for(i in 1:nC) {
  noncog[, cols[i]] <- split[ind + i - 1]
}

myFiles <- list.files(pattern="*_Coef_jackknife.csv")
difference_testing <- NULL
for (i in myFiles){
data <- read.table(i, header=T)
Annot <- strsplit(i, "_", perl=T)[[1]][1]

Corr <- cor(data$Cog, data$NonCog)

SE_Cog <- sd(data$Cog) * sqrt(198) # We multiply by 198 as each estimate is 199/200 of the sample (200 jackknife) and -1 degree of freedom 
SE_NonCog <- sd(data$NonCog) * sqrt(198) 
data$Diff <- data$Cog - data$NonCog
SE_Diff <- sd(data$Diff) * sqrt(198)  #get the standard error of the difference (standard deviation of the jackknife distribution)

Coef_Cog <- cog[cog$Annot == Annot,]$Coefficient
Coef_NonCog <- noncog[noncog$Annot == Annot,]$Coefficient
Coef_Diff <- Coef_Cog - Coef_NonCog
Z_Diff <- Coef_Diff / SE_Diff 
P_Diff <- 2*pnorm(-abs(Z_Diff)) 


#With standardized coefficients 
#data$Coef_stand_Cog <- data$Cog/SE_Cog
#data$Coef_stand_NonCog <- data$NonCog/SE_NonCog
#data$Diff_stand <- data$Coef_stand_Cog - data$Coef_stand_NonCog
#Corr_stand <- cor(data$Coef_stand_Cog, data$Coef_stand_NonCog)
#SE_Diff_stand <- sd(data$Diff_stand) * sqrt(198) 
#Av_Coef_stand_Cog <- mean(data$Coef_stand_Cog)
#Av_Coef_stand_NonCog <- mean(data$Coef_stand_NonCog)
#Coef_Diff_stand <- Av_Coef_stand_Cog - Av_Coef_stand_NonCog
#Z_Diff_stand <- Coef_Diff_stand / SE_Diff_stand 
#P_Diff_stand <- 2*pnorm(-abs(Z_Diff_stand)) 

#res <- cbind(Annot,Coef_Cog, Coef_NonCog, SE_Cog, SE_NonCog, Corr, Coef_Diff, SE_Diff, Z_Diff, P_Diff, 
#Av_Coef_stand_Cog, Av_Coef_stand_NonCog, Corr_stand, Coef_Diff_stand, SE_Diff_stand, Z_Diff_stand, P_Diff_stand)
res <- cbind(Annot,Coef_Cog, Coef_NonCog, SE_Cog, SE_NonCog, Corr, Coef_Diff, SE_Diff, Z_Diff, P_Diff)
difference_testing <- rbind(difference_testing, res) 
} 
difference_testing <- as.data.frame(difference_testing)
difference_testing$P_Diff_fdr <- p.adjust(difference_testing$P_Diff, method="fdr")
difference_testing$P_Diff_bonf <- p.adjust(difference_testing$P_Diff, method="bonferroni")

write.table(difference_testing, "difference_jackknife.csv", quote=F, row.names=F) 


