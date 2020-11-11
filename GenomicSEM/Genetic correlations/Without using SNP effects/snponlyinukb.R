##################################################
## Project: CogNonCog 2018
## Script purpose: Check SNP overlap COGENT and NonCog hits, and UKB CP GWAS
## Date: August 2020
## Author: Perline Demange 
##################################################

library(data.table)

# Check number of SNPs in NonCog GWAS that are only present in UKB GWAS (and not Cogent) ----
noncog <- fread("../GWAS_sumstats_23andMe/Non_Cognitive_GWAS_short_with23andMe.txt", header=T)
head(noncog) #7311269
cogent <- fread("CP_Cleaned_Aysu/CLEANED.COGENT.txt") 
head(cogent) #7986603

tot <- merge(noncog, cogent, by.x= "SNP", by.y="rsID") #7182893

commonsnp <- tot$SNP
commonsnp

onlyinukb <- noncog[!which(noncog$SNP %in% commonsnp),]
head(onlyinukb)
onlyinukb$chrpos <- paste(onlyinukb$CHR, onlyinukb$BP, sep=":")
# 128376 hits only in ukb 

# Check if some NonCog and Cog hits are only present in Cogent GWAS and not UKB ----
## Hits like Baselmans

coghits <- fread("Cog_23andMe_sig_independent_signals.txt")
noncoghits <- fread("NonCog_23andMe_sig_independent_signals.txt")

coghits_onlyUKB <- merge(onlyinukb, coghits, by.x="chrpos", by.y="V1")
coghits_onlyUKB # 1 hit rs3843954

noncoghits_onlyUKB <- merge(onlyinukb, noncoghits, by.x="chrpos", by.y="V1")
noncoghits_onlyUKB # NO HITS! 

## Hits like Lee
coghits <- fread("Cog_ind_sig_1000000kb.txt")
noncoghits <- fread("Non_Cog_sig_ind_sign_1000000kb.txt")

coghits_onlyUKB <- merge(onlyinukb, coghits, by.x="chrpos", by.y="V1")
coghits_onlyUKB # 1 hit rs3843954

noncoghits_onlyUKB <- merge(onlyinukb, noncoghits, by.x="chrpos", by.y="V1")
noncoghits_onlyUKB # NO HITS! 

## Hits like Ripke 
coghits <- fread("Cog_Ripke_loci.clumped")
noncoghits <- fread("NonCog_Ripke_loci.clumped")

coghits_onlyUKB <- merge(onlyinukb, coghits, by.x="chrpos", by.y="SNP")
coghits_onlyUKB # 1 hit rs3843954

noncoghits_onlyUKB <- merge(onlyinukb, noncoghits, by.x="chrpos", by.y="SNP")
noncoghits_onlyUKB # NO HITS! 

## check if the hit is there but with another rsid -> chr:pos 
cogent[which(cogent$cptid == "13:58548511"),] #no 


# Check number of snps in COGENT not in  meta-analysis CP GWAS ----

cp <- fread("C:/Users/PDE430/Documents/CogNonCog/Analyses/Full data/Lee_2018_GWAS_CP_all.txt", header=T)
head(cp) #100098325
cpcogent <- merge(cp, cogent, by.x= "MarkerName", by.y="rsID")
#7850755 so 
7986603-7850755
#135848 SNPs in cogent not in CP metanaalysis 

# Check difference between Cogent not cleaned by Lee et al and Cogent cleaned by lee et al ----

precogent <- fread("cogent.hrc.meta.chr.bp.rsid.assoc.full.cl")
#8040130
head(precogent)

snpinnoncleaned <- precogent$SNP
onlyincleaned <- cogent[!which(cogent$rsID %in% snpinnoncleaned),]
# 48326 SNPs are only in the cleaned sumstats!

#check with chr:pos instead of rsid 
chrpos <- onlyincleaned$cptid
check <- precogent[which(precogent$cptid %in% chrpos)]
head(check)
View(onlyincleaned)
#Actually there are in common if you look at the chr pos!
#So difference between cleaned and noncleaned cogent sumstats is rsID! 



# Check hit in Cog only in UKB, look for proxy in Cogent -----

# rs3843954 13:58548511
cog <- fread("../GWAS_sumstats_23andMe/Cognitive_GWAS_short_with23andMe.txt", header=T)
head(cog)
cog13 <- cog[cog$CHR ==13,]
cog13[which(cog13$P < 0.00000005), ]
# closest snp is  rs9537888  13  58551353  G  T -0.04226936 0.007159315 -5.904106 3.545642e-09
# is present in cogent 

# Check how many of only in ukb snp are in the hm3 file used for ldsc ----

hm3 <- fread("D:/Documents/CogNonCog/Analyses/GSEM_with23andME/Sumstats/w_hm3.noMHC.snplist")
head(hm3)
hm3snp <- hm3$SNP
inhm3 <- onlyinukb[onlyinukb$SNP %in% hm3snp,]


# Add column in summary statistics ot mention which SNps are onlyinUKB -----
cogent <- fread("CP_Cleaned_Aysu/CLEANED.COGENT.txt") 
ukb <- fread("CP_Cleaned_Aysu/CLEANED.UKBCP.txt") 
cog <- fread("../GWAS_sumstats_Cog_NonCog_Demange_et_al/Cog_GWAS_excl23andMe.txt")
noncog <- fread("../GWAS_sumstats_Cog_NonCog_Demange_et_al/NonCog_GWAS_excl23andMe.txt")

ukbtot <- merge(ukb, cog, by.x="rsID", by.y="SNP") #all snp in ukb
cogentot <- merge(cogent, cog, by.x="rsID", by.y="SNP")#7177153

cog$CP_UKB_only <- ifelse(cog$SNP %in% cogentot$rsID,"No", "Yes") 
table(cog$CP_UKB_only) 
# No     Yes 
# 7177153  128803 
rm(ukbtot)
rm(cogentot)
ukbtotn <- merge(ukb, noncog, by.x="rsID", by.y="SNP") #all snp in ukb
cogentotn <- merge(cogent, noncog, by.x="rsID", by.y="SNP")#7177153

noncog$CP_UKB_only <- ifelse(noncog$SNP %in% cogentotn$rsID,"No", "Yes") 
table(noncog$CP_UKB_only) 

write.table(cog, "Cog_GWAS_excl23andMe_20200806.txt") #on dropbox
write.table(noncog, "NonCog_GWAS_excl23andMe_20200806.txt")


noncog <- read.table("NonCog_GWAS_excl23andMe_20200806.txt")

## change column name for  GWAS catalog 
cog <- fread("../GWAS_sumstats_Cog_NonCog_Demange_et_al/Cog_GWAS_excl23andMe_20200806.txt")
cog <- cog[,2:12] # remove rowname as column 
head(cog)
names(cog) <- c("variant_id", "chromosome", "base_pair_location", "effect_allele", "other_allele", "MAF", "est", "standard_error", "Z", "p_value", "CP_UKB_only")
write.table(cog, file="Cog_GWAS_excl23andMe_20201104.tsv", quote=F, sep='\t', row.names=F)

noncog <- fread("../GWAS_sumstats_Cog_NonCog_Demange_et_al/NonCog_GWAS_excl23andMe_20200806.txt")
noncog <- noncog[,2:12] 
head(noncog)
names(noncog) <- c("variant_id", "chromosome", "base_pair_location", "effect_allele", "other_allele", "MAF", "est", "standard_error", "Z", "p_value", "CP_UKB_only")
write.table(noncog, file="NonCog_GWAS_excl23andMe_20201104.tsv", quote=F, sep='\t', row.names=F)
