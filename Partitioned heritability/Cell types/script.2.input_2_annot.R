source("/home/pdemange/CogNonCog/Annotations/Mouse_annotation/Basefiles/make.LDSR.annot_v2_4_6.R")

type.num<-as.numeric(commandArgs(trailingOnly=T)[1])
type.name<-commandArgs(trailingOnly=T)[2]

geneCode<-fread("/home/pdemange/CogNonCog/Annotations/Mouse_annotation/Basefiles/Geneloc_duplicated_excluded.txt",header=T,showProgress=F,data.table=F) #map of human genes, positions
mouse.human.hom<-fread("/home/pdemange/CogNonCog/Annotations/Mouse_annotation/Basefiles/HOM_MouseHumanSequence.gencode_v19.list",header=T,showProgress=F,data.table=F)

# Take the 10% most specific genes per celltypes
dat<-fread("/home/pdemange/CogNonCog/Annotations/Mouse_annotation/Basefiles/Mouseatlas_specific_expression_L5.txt",header=T,select=c(1,type.num),showProgress=F,data.table=F)
dat<-unique(dat[dat[,2]>=quantile(dat[,2],prob=1-10/100),1])

input<-unique(mouse.human.hom[mouse.human.hom[,2]%in%dat,1]) # get the human ID from the corresponding mouse ID 

make.LDSR.annot(input,"/home/pdemange/CogNonCog/Annotations/Mouse_annotation/shoulder10k_nowindow_baselineld2.2/ANNOTS/",annot.name=type.name,"/home/pdemange/CogNonCog/Annotations/LDScores_base_files/1000G_Phase3_baselineLD_v2.2/baselineLD","name",add.windows=F,GeneCode=geneCode, gene.shoulder=10000)
