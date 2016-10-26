##
# On a data frame, transform numbers trate as character to numeric
#
# leon.alvarado12@gmail.com

toNum <-function(x){
 out <- matrix(NA, nrow = length(rownames(x)), ncol = length(colnames(x)))
 for (i in 1:length(colnames(x))){
   out[,i] <- as.numeric(x[,i])
 }
 colnames(out) <- colnames(x)
 rownames(out) <- rownames(x)
 
 return(out)
}

 
#At the end, all characters in the data frame will be numeric type variables.

# Useful_scripts
