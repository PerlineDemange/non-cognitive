#!/bin/bash

# We had to modify this script compared to analysis wihtout jackknife,as an update of LISA made using --export not possible 

j=0
for ANNOT in $(ls /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/*.1.annot.gz | sed 's!/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/!!g' | sed 's!.1.annot.gz!!g');do
j=$(( j + 1 ))
cp 02_annotation_cog_mice_jackknife.sh tmp_02_annotation_cog_mice_jackknife.sh
cp 02_annotation_Noncog_mice_jackknife.sh tmp_02_annotation_Noncog_mice_jackknife.sh
sed -i 's!__ANNOT__!'${ANNOT}'!g' tmp_02_annotation_cog_mice_jackknife.sh
sed -i 's!__ANNOT__!'${ANNOT}'!g' tmp_02_annotation_Noncog_mice_jackknife.sh
sbatch tmp_02_annotation_cog_mice_jackknife.sh
sbatch tmp_02_annotation_Noncog_mice_jackknife.sh
rm tmp_*jackknife.sh
if [[ $(( j % 5 )) == 0 ]];then
sleep 1
fi
done 