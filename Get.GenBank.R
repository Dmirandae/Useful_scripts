#How to download sequences from GenBank
#
#leon.alvarado12@gmail.com
 
#######################################################################################
#                            Use a data without NA                                    #
#                                                                                     #
#This function need a data frame with the two first columns calling Genera and Specie #
#                                                                                     #
#######################################################################################
 
GB.no.na <- function(x){
  #Separe genes from species' names
 
  genes <- x[,3:length(colnames(x))]
  
  #Genes names
  genes.n <- colnames(genes)
 
  #Now download sequences for each gene
  
  for (i in 1:length(colnames(genes))){
    seq <- read.GenBank(genes[,i])
      names(seq) <- paste(x[,1],x[,2],sep="_") #Assing specie name to each sequence 
    gen <- genes.n[i] #The name of the gene
    write.dna(seq,file=gen,format="fasta") #Here we get a fasta file with the name of each gene
  }
}
 
#######################################################################################
#                                Use a data with NA                                   #
#                                                                                     #
#This function need a data frame with the two first columns calling Genero and Specie #
#                                                                                     #
#######################################################################################
 
GB.na <- function(x){
 
  #Separe genes from data frame
  genes <- x[,3:length(colnames(x))]
  
  #Genes' names
  gen.nn <- colnames(genes)
 
  #Now download sequence for each gene
  for (i in 1:length(colnames(genes))){
    gen <- genes[,i]
      names(gen) <- paste(x[,1],x[,2],sep="_")
    gen2 <- na.omit(gen) #Here the NA are removes
      gen.n <- names(na.omit(gen)) # Here just the species names with no NA value are extracting
    seq <-read.GenBank(gen2)
      names(seq) <- gen.n
    n <- gen.nn[i]
      write.dna(seq,file=n,format="fasta")  #Here we get a fasta file with the name of each gen
  }
  
}

# Useful_scripts
