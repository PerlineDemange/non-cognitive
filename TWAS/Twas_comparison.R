setwd("./TWAS")
library(data.table)

#############
## Get data
############


cog <- fread("D:/Documents/CogNonCog/Analyses/Annotations/TWAS/TWAS.Brain.Cog.ALL", stringsAsFactors = F)
head(cog)
noncog <- fread("D:/Documents/CogNonCog/Analyses/Annotations/TWAS/TWAS.Brain.NonCog.ALL", stringsAsFactors = F)
head(noncog)

twas <- merge(cog, noncog, by=c("PANEL", "FILE", "ID", "CHR", "P0", "P1", "HSQ"), suffixes = c(".Cog", ".NonCog"))
head(twas)
summary(twas)

#We need to remove the NAs (4 genes)
twasna <- twas[, 2:ncol(twas)]
head(twasna)
twas <- na.omit(twasna)
head(twas)
write.table(twas, file="twas_results.txt", row.names=F, sep=" ")

### Write results for paper ###
#install.packages("writexl")
library(writexl)
write_xlsx(twas, "twas_results.xlsx")

########################
## Histogram of zscore 
#####################

# We also overlay a normal distribution of noise N(0,1)
x = twas$TWAS.Z.Cog
m<-0
std<-1
hist(x, breaks=20, freq=F, ylim=c(0, 0.5),
     xlab="TWAS.Z Cog", main="Histogram of Z score of Cog TWAS")
curve(dnorm(x, mean=m, sd=std), 
      col="darkblue", lwd=2, add=TRUE)

x = twas$TWAS.Z.NonCog
m<-0
std<-1
hist(x, breaks=20, freq= F, ylim=c(0, 0.5),
     xlab="TWAS.Z NonCog", main="Histogram of Z score of NonCog TWAS")
curve(dnorm(x, mean=m, sd=std), 
      col="darkblue", lwd=2, add=TRUE)

################
## Plot Z score 
################

plot(twas$TWAS.Z.Cog, twas$TWAS.Z.NonCog)
cor(twas$TWAS.Z.Cog, twas$TWAS.Z.NonCog, method="spearman", use ="pairwise.complete.obs")
summary(twas)

twas$TWAS.P.Cog.fdr <- p.adjust(twas$TWAS.P.Cog, method ="fdr")
cog_sig <- twas[twas$TWAS.P.Cog<0.05, ]
both_sig <- cog_sig[cog_sig$TWAS.P.NonCog<0.05, ]
plot(both_sig$TWAS.Z.Cog, both_sig$TWAS.Z.NonCog)


#################
## Noise plot
###################
# We build noise estimate of Cog and NonCog that correspond to the noise correlation we estimate with the Cross Trait Intercept
require(MASS)
i <- -.67
s <- diag(2)
s[1,2] <- s[2,1] <- i
data <- mvrnorm(5378,c(0,0),s) #5378 number of genes (excluding the ones with NA)
head(data)
noise <- as.data.frame(data)
names(noise) <- c("noise.Cog", "noise.NonCog")
head(noise)
twas_noise <- cbind(twas, noise)
head(twas_noise)

Pvalue_corrected = 0.05/5378
CI_level_corrected= 1- Pvalue_corrected

## Plot with: 
# histogram + noise distribution
# scatterplot zscore + elipse of the noise 
# use Jaap solution https://stackoverflow.com/questions/19949435/3d-plot-of-bivariate-distribution-using-r-or-matlab/22902660
library(ggplot2)
library(gridExtra)
library(devtools)
source_url("https://raw.github.com/low-decarie/FAAV/master/r/stat-ellipse.R") # needed to create the 95% confidence ellipse # this ocde is provided at the end of this cript 

htop <- ggplot(data=twas_noise, aes(x=TWAS.Z.Cog)) + 
  geom_histogram(aes(y=..density..), fill = "white", color = "black", binwidth = 1) + 
  #stat_density(colour = "blue", geom="line", size = 1.5, position="identity", show_guide=FALSE) +
  stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 1), color="blue") + ylab("") +
  #scale_x_continuous(breaks = 40) + 
  scale_y_continuous("Count") + 
  theme_bw() + theme(axis.title.x = element_blank())

blank <- ggplot() + geom_point(aes(1,1), colour="white") +
  theme(axis.ticks=element_blank(), panel.background=element_blank(), panel.grid=element_blank(),
        axis.text.x=element_blank(), axis.text.y=element_blank(), axis.title.x=element_blank(), axis.title.y=element_blank())

scatter <- ggplot(data=twas_noise, aes(x=noise.Cog, y=noise.NonCog)) + 
  geom_point(aes(x=TWAS.Z.Cog, y=TWAS.Z.NonCog), size=0.6,) +
  #geom_point(size=0.6, color="orange") +
  stat_ellipse(level = 0.9999907, size = 1, color="red") +
  stat_ellipse(level = 0.95, size = 1, color="blue") +
  stat_ellipse(level = 0.68, size = 1, color="blue") +
  scale_x_continuous("TWAS Z Cog") + 
  scale_y_continuous("TWAS Z NonCog") + 
  theme_bw()

hright <- ggplot(data=twas_noise, aes(x=TWAS.Z.NonCog)) + 
  geom_histogram(aes(y=..density..), fill = "white", color = "black", binwidth = 1) + 
  #stat_density(colour = "red", geom="line", size = 1, position="identity", show_guide=FALSE) +
  stat_function(fun = dnorm, n = 101, args = list(mean = 0, sd = 1), color="blue") + ylab("") +
  #scale_x_continuous("V2", limits = c(-20,20), breaks = c(-20,-10,0,10,20)) + 
  scale_y_continuous("Count") + 
  coord_flip() + theme_bw() + theme(axis.title.y = element_blank())

grid.arrange(htop, blank, scatter, hright, ncol=2, nrow=2, widths=c(4, 1), heights=c(1, 4))

##################################
### Manhattan plot of the genes 
################################

library(qqman)

significance= 0.05/nrow(twas)
manhattan(twas, chr="CHR", bp="P0", p="TWAS.P.Cog", genomewideline = -log10(significance), suggestiveline=F)
manhattan(twas, chr="CHR", bp="P0", p="TWAS.P.NonCog", genomewideline = -log10(significance), suggestiveline=F)
