avtd.root <- function(Phylo, Dist){
  
  rootName <- find.root(Phylo)
  
  for(i in 1:length(Dist[,1])){
    
    l <- grep(1,Dist[i, ])
    
    if(length(l)==1){
      
      Dist[i,grep(rootName,colnames(Dist))] <- 1
      
    }
    
  }
  
  return(Dist)
}
