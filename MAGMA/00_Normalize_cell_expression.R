##################################################
## Project: CogNonCog 2018
## Script purpose: Normalize cell expression (data from Zeisel et al. 2018)
##################################################


mouseatlas_matrix <- read_delim("mouseatlas_matrix.txt","\t", escape_double = FALSE, col_names = FALSE,trim_ws = TRUE)
mouseatlas_col_attrs <- read_delim("mouseatlas_col_attrs.txt","\t", escape_double = FALSE, trim_ws = TRUE)
mouseatlas_row_attrs <- read_delim("mouseatlas_row_attrs.txt","\t", escape_double = FALSE, trim_ws = TRUE)

matrix_Nc <- mouseatlas_matrix


M1 <- mouseatlas_matrix[rowSums(mouseatlas_matrix !=0) > 50,]
M2 <- M1[rowSums(M1) > quantile(rowSums(M1),probs = .25),]
matrix_Nc <- M2


N1 <- mouseatlas_row_attrs[rowSums(mouseatlas_matrix !=0) > 50,]
N2 <- N1[rowSums(M1) > quantile(rowSums(M1),probs = .25),]

for(i in 1:nrow(M2)){
  
  matrix_Nc[i,] <- M2[i,]/colSums(M2)
  
}


for(i in 1:ncol(matrix_Nc)){
  
  matrix_Nc[,i] <- matrix_Nc[,i]/rowSums(matrix_Nc)
  
}

rank <-  as.matrix(matrix_Nc)

for(i in 1:ncol(matrix_Nc)){
  
  rank[,i] <- 12119-rank(as.matrix(matrix_Nc[,i]))
  
}

View(matrix_Nc)


corrplot(cor(matrix_Nc),addgrid.col = NA)

Dataset_specific_expression <- cbind.data.frame(N2$Gene,matrix_Nc)
colnames(Dataset_specific_expression ) <- c("Gene",mouseatlas_col_attrs$ClusterName)



write.table(Dataset_specific_expression,file = "Mouseatlas_specific_expression_L5.txt",row.names=F,quote=F)



