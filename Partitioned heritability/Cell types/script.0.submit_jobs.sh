#!/bin/bash

cd /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/Scripts

head -n1 /home/pdemange/CogNonCog/Annotations/Mouse_annotation/Basefiles/Mouseatlas_specific_expression_L5.txt | sed 's! !\n!g' > cellType.names
# takes the header in the first line and sed it such as making one column out of the headers (which are the names of the cell types)

for i in $(seq 2 $(head -n1 /home/pdemange/CogNonCog/Annotations/Mouse_annotation/Basefiles/Mouseatlas_specific_expression_L5.txt | sed 's! !\n!g' | wc -l));do
ANNOT=$( sed "${i}q;d" cellType.names ) # annot is defined as the word which is in position ${i} in the column cellType.names
sbatch --export=i=${i},ANNOT=${ANNOT} script.1.input_2_annot.sh
if [[ $(( i % 5 )) == 0 ]];then 
sleep 1
fi
done
# sleeps for one second every 5 steps

mv cellType.names /home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2
echo "DONE"

