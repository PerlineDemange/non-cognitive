### Create a manhattan plot with Cog and NonCog summary statistics 
### Using the function adapted by Hill Ip

library(data.table)
source("C:/Users/HIP200/Dropbox/999_assorted_functions_and_scripts/003_own_manhattan/own_manhattan.R")

setwd("./Hits_Manhattan")

load("../output/Cognitive_GWAS_with23andMe.RData")
load("../output/Non_Cognitive_GWAS_with23andMe.RData")
Cog_sig_ind <- read.table(file="Cog_23andMe_sig_independent_signals.txt", col.names = c("CHR:POS","P") )
Non_Cog_sig_ind <- read.table(file="NonCog_23andMe_sig_independent_signals.txt", col.names = c("CHR:POS","P") )
Cog_sig_ind <- as.vector(Cog_sig_ind$CHR.POS)
Non_Cog_sig_ind <- as.vector(Non_Cog_sig_ind$CHR.POS)

cognitivetot$CHR.POS <- paste(cognitivetot$CHR, cognitivetot$BP, sep=":")
noncogtot$CHR.POS <- paste(noncogtot$CHR, noncogtot$BP, sep=":")


########################
## Cognitive #########
######################

col <- c("slategray", "slategray1")

ref_mat<-data.frame(CHR=1:22,MAX_POS=c(249250621,243199373,198022430,191154276,180915260,171115067,159138663,146364022,141213431,135534747,135006516,133851895,115169878,107349540,102531392,90354753,81195210,78077248,59128983,63025520,48129895,51304566),stringsAsFactors=F)
ref_mat$START<-1
for(i in 2:22){
  ref_mat[i,]$START<-sum(ref_mat[1:(i-1),]$MAX_POS)+1
}
ref_mat$END<-ref_mat$START+ref_mat$MAX_POS-1
ref_mat$lab_pos<-rowMeans(ref_mat[,c('START','END')])

#x <- fread("001_Main_GWAMA/CLEANED.AGG_0.txt",header=T,select=c(1:3,13),showProgress=F,data.table=F)
x <- cognitivetot
x$PVAL <- x$P
x$POS <- x$BP 
x <- x[x$PVAL<=0.01,]
x$P <- -log10(x$PVAL)
#colnames(x)<-c("SNP","CHR","POS","P")
chrs<-sort(unique(x$CHR))
dat<-vector('list',length(chrs))
for(i in 1:length(chrs)){
  dat[[i]]<-x[x$CHR==chrs[i],]
}
dat<-lapply(X=dat,FUN=function(x,y=ref_mat){
  y<-y[y$CHR==x[1,]$CHR,]
  if(max(x$POS)>y$MAX_POS){
    stop(paste0('The highest base-pair position at chromosome ',y$CHR,' (',max(x$POS),') is larger than the maximum in the reference (',y$MAX_POS,')\n  The SNPs might have been mislabeled\n'),call.=F)
  }
  if(is.unsorted(x$POS)){
    x<-x[order(x$POS),]
  }
  x$POS<-x$POS+y$START-1
  return(x)
})
x<-do.call(rbind.data.frame,dat)
rm(dat)
x$COL<-NA
for(i in 1:22){
  if(sum(x$CHR)>0){
    if(sum(x$CHR==i)>0){
      if(length(col)==1){
        x[x$CHR==i,]$COL<-rainbow(22)[i]
        x[x$CHR==i,]$COL2<-anti_rainbow[i]
      }else{
        if((i %% 2)==1){
          x[x$CHR==i,]$COL<-col[1]
        }else{
          x[x$CHR==i,]$COL<-col[2]
        }
      }
    }
  }
}

x$pch <- 19
x$cex <- 0.3

#x[x$CHR==1 & x$POS %in% 44173204:44396837,]$COL <- "darkgreen"
#x[x$CHR==1 & x$POS %in% 44173204:44396837,]$pch <- 17
#x[x$CHR==1 & x$POS %in% 44173204:44396837,]$cex <- 0.6
#
#START <- 30721951 +ref_mat[ref_mat$CHR==4,]$START+1
#END <- 31148423 +ref_mat[ref_mat$CHR==4,]$START+1
#
#x[x$CHR==4 & x$POS %in% START:END,]$COL <- "darkgreen"
#x[x$CHR==4 & x$POS %in% START:END,]$pch <- 17
#x[x$CHR==4 & x$POS %in% START:END,]$cex <- 0.6
#
#dum <- x[(x$CHR==1 & x$POS %in% 44173204:44396837) | x$CHR==4 & x$POS %in% START:END,]

indep.signif.hits <- x[x$CHR.POS %in% Cog_sig_ind,c("POS","P")]

#####
tiff(filename="test_hill.tiff",width=2480,height=3508/2,units="px",res=300,type="cairo")
par(mar=c(2,2,1,0))
plot(x=x$POS,y=x$P,ylim=c(2,30),xlab = '',ylab = '',xaxt='n',yaxt='n',pch=x$pch,col=x$COL,bty='n',cex=x$cex)

## add highlights
#points(x=dum$POS,y=dum$P,pch=dum$pch,col=dum$col,cex=dum$cex)
points(x=indep.signif.hits$POS,y=indep.signif.hits$P,pch=17,col="mediumvioletred",cex=0.7)

x0 <- par('usr')[1]
x1 <- par('usr')[2]
x_range <- (x1 - x0)
x_end <- x0 + 0.03 * x_range

y0 <- par('usr')[3]
y1 <- par('usr')[4]
y_range <- y1 - y0

## add x-axis and labels
for(pos in c(ref_mat$START,ref_mat[22,]$END)){
  segments(x0=pos,y0=2 - 0.01 * y_range,x1=pos,y1=2 - 0.025 * y_range,xpd=T,cex=0.55)
}
segments(x0=1,y0=2 - 0.01 * y_range,x1=ref_mat[22,]$END,y1=2 - 0.01 * y_range, xpd=T, cex=0.55)
text(x=ref_mat$lab_pos,labels=1:22,y=2 - 0.04 * y_range,xpd=T,cex=0.55)
text(x=ref_mat[22,]$END/2,y=2 - 0.07 * y_range,xpd=T,labels="Chromosome",cex=0.7)

## add suggestive line
segments(x0=x_end,y0=5,x1=ref_mat[22,]$END,y1=5,lty=2,cex=0.55)

## add genome-wide significance line
segments(x0=x_end,y0=-log10(5*10^-8),x1=ref_mat[22,]$END,y1=-log10(5*10^-8),lty=2,cex=0.55,col="red")

## add y-axis and labels
segments(x0=x_end,y0=2, x1=x_end, y1=30, xpd=T)
for(pos in seq(from=2,to=30,by=4)){
  segments(x0=x_end,y0=pos,x1=x_end - 0.015 * x_range,y1=pos,xpd=T,cex=0.55)
  text(x=x_end - 0.025 * x_range,y=pos,labels=pos,xpd=T,cex=0.7)
}
text(x=x_end - 0.06 * x_range,y=15.5,labels=expression("-log"["10"]*"("*italic(P)*")"),xpd=T,cex=0.8,srt=90)
dev.off()


#################
###  NonCog #####
#################


col <- c("#FF9900", "#FF6600")
#col <- c("#ff9933", "#ff3333")

ref_mat<-data.frame(CHR=1:22,MAX_POS=c(249250621,243199373,198022430,191154276,180915260,171115067,159138663,146364022,141213431,135534747,135006516,133851895,115169878,107349540,102531392,90354753,81195210,78077248,59128983,63025520,48129895,51304566),stringsAsFactors=F)
ref_mat$START<-1
for(i in 2:22){
  ref_mat[i,]$START<-sum(ref_mat[1:(i-1),]$MAX_POS)+1
}
ref_mat$END<-ref_mat$START+ref_mat$MAX_POS-1
ref_mat$lab_pos<-rowMeans(ref_mat[,c('START','END')])

#x <- fread("001_Main_GWAMA/CLEANED.AGG_0.txt",header=T,select=c(1:3,13),showProgress=F,data.table=F)
x <- noncogtot
x$PVAL <- x$P
x$POS <- x$BP 
x <- x[x$PVAL<=0.01,]
x$P <- -log10(x$PVAL)
#colnames(x)<-c("SNP","CHR","POS","P")
chrs<-sort(unique(x$CHR))
dat<-vector('list',length(chrs))
for(i in 1:length(chrs)){
  dat[[i]]<-x[x$CHR==chrs[i],]
}
dat<-lapply(X=dat,FUN=function(x,y=ref_mat){
  y<-y[y$CHR==x[1,]$CHR,]
  if(max(x$POS)>y$MAX_POS){
    stop(paste0('The highest base-pair position at chromosome ',y$CHR,' (',max(x$POS),') is larger than the maximum in the reference (',y$MAX_POS,')\n  The SNPs might have been mislabeled\n'),call.=F)
  }
  if(is.unsorted(x$POS)){
    x<-x[order(x$POS),]
  }
  x$POS<-x$POS+y$START-1
  return(x)
})
x<-do.call(rbind.data.frame,dat)
rm(dat)
x$COL<-NA
for(i in 1:22){
  if(sum(x$CHR)>0){
    if(sum(x$CHR==i)>0){
      if(length(col)==1){
        x[x$CHR==i,]$COL<-rainbow(22)[i]
        x[x$CHR==i,]$COL2<-anti_rainbow[i]
      }else{
        if((i %% 2)==1){
          x[x$CHR==i,]$COL<-col[1]
        }else{
          x[x$CHR==i,]$COL<-col[2]
        }
      }
    }
  }
}

x$pch <- 19
x$cex <- 0.3

indep.signif.hits <- x[x$CHR.POS %in% Non_Cog_sig_ind,c("POS","P")]

#####
tiff(filename="NonCog_hill_triangle.tiff",width=2480,height=3508/2,units="px",res=300,type="cairo") #width2480 #posterwidth5960
par(mar=c(2,2,1,0))
plot(x=x$POS,y=x$P,ylim=c(2,22),xlab = '',ylab = '',xaxt='n',yaxt='n',pch=x$pch,col=x$COL,bty='n',cex=x$cex)

## add highlights
#points(x=dum$POS,y=dum$P,pch=dum$pch,col=dum$col,cex=dum$cex)
points(x=indep.signif.hits$POS,y=indep.signif.hits$P,pch=17,col="mediumvioletred",cex=0.7) #pch 17 is triangle #mediumvioletred #pch4 is cross

x0 <- par('usr')[1]
x1 <- par('usr')[2]
x_range <- (x1 - x0)
x_end <- x0 + 0.03 * x_range

y0 <- par('usr')[3]
y1 <- par('usr')[4]
y_range <- y1 - y0

## add x-axis and labels
for(pos in c(ref_mat$START,ref_mat[22,]$END)){
  segments(x0=pos,y0=2 - 0.01 * y_range,x1=pos,y1=2 - 0.025 * y_range,xpd=T,cex=0.55)
}
segments(x0=1,y0=2 - 0.01 * y_range,x1=ref_mat[22,]$END,y1=2 - 0.01 * y_range, xpd=T, cex=0.55)
text(x=ref_mat$lab_pos,labels=1:22,y=2 - 0.04 * y_range,xpd=T,cex=0.55)
text(x=ref_mat[22,]$END/2,y=2 - 0.07 * y_range,xpd=T,labels="Chromosome",cex=0.7)

## add suggestive line
segments(x0=x_end,y0=5,x1=ref_mat[22,]$END,y1=5,lty=2,cex=0.55)

## add genome-wide significance line
segments(x0=x_end,y0=-log10(5*10^-8),x1=ref_mat[22,]$END,y1=-log10(5*10^-8),lty=2,cex=0.55,col="red")

## add y-axis and labels
segments(x0=x_end,y0=2, x1=x_end, y1=30, xpd=T)
for(pos in seq(from=2,to=30,by=4)){
  segments(x0=x_end,y0=pos,x1=x_end - 0.015 * x_range,y1=pos,xpd=T,cex=0.55)
  text(x=x_end - 0.025 * x_range,y=pos,labels=pos,xpd=T,cex=0.7)
}
text(x=x_end - 0.06 * x_range,y=15.5,labels=expression("-log"["10"]*"("*italic(P)*")"),xpd=T,cex=0.8,srt=90)
dev.off()