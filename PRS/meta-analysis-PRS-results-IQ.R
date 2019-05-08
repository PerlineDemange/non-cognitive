require(metafor)
require(ggplot2)
# read in data:
Allcohorts_PGS_cognition_meta_180219 <- read.csv("Allcohorts_PGS_cognition_meta_180219.csv",strip.white=TRUE)
View(Allcohorts_PGS_cognition_meta_180219)

#rename to something short
data <- Allcohorts_PGS_cognition_meta_180219

# omit EA 3 for now:

data <- data[data$PGS != "EA",]

# Omit NA

data <- data[,1:9]
data <- na.omit(data)
data<- droplevels(data)
# Omit Verbal, full scale and Perfromance

data <- data[data$Type != "FSIQ" & data$Type != "Verbal" & data$Type != "Performance",]

meta_regression_null <- rma.mv(yi = Beta,V = diag(SE^2),random= ~ 1 | Cohort,data=data)
summary(meta_regression_null)

meta_regression_01 <- rma.mv(yi = Beta,V = diag(SE^2), mods = ~ -1 + PGS,intercept = FALSE,random= ~ 1| Cohort,data=data)
summary(meta_regression_01)


meta_regression_01b <- rma.mv(yi = Beta,V = diag(SE^2), mods = ~  PGS,random= ~ 1| Cohort,data=data)
summary(meta_regression_01b)

meta_regression_02 <- rma.mv(yi = Beta,V = diag(SE^2), mods = ~ PGS*Type,intercept = FALSE,random= ~ 1 | Cohort,data=data)
summary(meta_regression_02)
