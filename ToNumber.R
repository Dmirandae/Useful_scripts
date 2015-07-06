toNum <- function(x){
 for (i in 1:length(x)){
   matrix <- as.matrix(x)
   x[,i] <- as.numeric(matrix[,i])  
 }
}
 
#At the end, all characters in the data frame will be numeric type variables.

