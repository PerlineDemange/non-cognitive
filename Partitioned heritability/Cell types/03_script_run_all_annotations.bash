#!/bin/bash

# create a list with the name of the files with the annotation: get a list of all the files in the folder annotation, remove the path to this filename and remove the suffixe 1.annot.gz
# J is incremented to be able to submit 5 jobs at a time and then wait one second, so that Lisa does not crash 

j=0
for ANNOT in $(ls /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/*.1.annot.gz | sed 's!/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/!!g' | sed 's!.1.annot.gz!!g');do
j=$(( j + 1 ))
qsub -v ANNOT=${ANNOT} 02_annotation_cog_mice.bash
qsub -v ANNOT=${ANNOT} 02_annotation_Noncog_mice.bash
if [[ $(( j % 5 )) == 0 ]];then
sleep 1
fi
done
