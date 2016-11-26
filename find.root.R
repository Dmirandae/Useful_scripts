find.root <- function(Phylo){
  
  library(ape, verbose = F,quietly = T)
  library(phangorn,verbose = F, quietly = T)
  
  ##########################################
  # Filter
  if(class(Phylo)!="phylo"){
    stop("Your input must be a class phylo")
  }
  if(is.rooted(Phylo)==F){
    stop("Your phylogeny must be rooted")
  }
  ###########################################
  
  RootNode <- length(Phylo$tip.label)+1
  
  Option <- c(1,length(Phylo$tip.label))
  
  RootTip <- c()
  
  for(i in 1:2){
    
    tip <- Option[i]
    
    Anc <- Ancestors(Phylo,tip)
    
    if(length(Anc)==1){
      
      RootTip <- Phylo$tip.label[Option[i]]
      
    }
    
  }
  
  if(is.null(RootTip)){
    
    warning("Your root terminal are not a unique specie, thus, just one will choose")
    
    for(i in 1:2){
      
      tip <- Option[i]
      
      Anc <- Ancestors(Phylo,tip)
      
      if(length(Anc)==2){
        
        RootTip <- Phylo$tip.label[Option[i]]
        
      }
    
    
    }
  
  }

  return(RootTip)
    
}
