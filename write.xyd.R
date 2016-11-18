write.xyd <- function(Occ,OutFile){

data <- Occ

out <- paste(OutFile,"xyd", sep=".")

species.unic <- unique(data[ ,1])

occ_dist <- paste(data[,3],data[,2],sep=" ")

data2 <- matrix(0,nrow=length(data[ ,1]),ncol=2)

data2[,1] <- as.character(data[,1])
data2[,2] <- occ_dist
colnames(data2) <- c("Sp","Occ")

data2 <- as.data.frame(data2)

n.sp <- 0:(length(species.unic)-1)


write(paste("spp",as.character(length(species.unic),sep=" ")),file = out)
write("nocommas",file = out,append = T,sep = "\n")
write("xydata",file = out,append=T,sep = "\n")
write(" ",file = out,append = T,sep = "\n")


for (i in 1:length(species.unic)){

  title <- paste("sp",n.sp[i],sep=" ")
  title <- paste(title,"[")
  title <- paste(title,species.unic[i])
  title <- paste(title,"]")
  ## Create the species title in this way
  
  write(x = title,file = out,append=T,sep="\n") ##Write the species title
  write(x = as.character(data2$Occ[data2$Sp==species.unic[i]]),file= out,append=T,sep="\n")
  ##Finally wrtie all occurences of the current species
  
}

}
