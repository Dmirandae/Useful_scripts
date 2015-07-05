#######################################
# write xyd file from GBIF occurences #
#######################################

#######################################
# Download occurences using a polygon.

polygon <-'POLYGON((-79.189453 -7.449624,-75.849609 -7.275292,-77.607421 -3.162455,-75.849609 0.087890,-67.851562 10.401377,-71.542968 12.125264,-72.861328 11.630715,-74.025878 11.307707,-75.080566 10.984335,-75.607910 9.968850,-75.915527 9.384032,-76.926269 8.537565,-77.365722 8.602747,-77.915039 7.318881,-77.299804 5.900188,-77.519531 5.615985,-77.497558 4.193029,-77.277832 3.601142,-77.739257 2.811371,-78.420410 2.438228,-78.684082 2.108898,-78.947753 1.669685,-79.057617 1.032658,-79.804687 0.900841,-80.024414 0.790990,-80.062866 0.823946,-80.106811 0.637193,-79.974975 0.521843,-80.068359 0.450434,-80.024414 0.181274,-80.321044 -0.186767,-80.480346 -0.373532,-80.485839 -0.714092,-80.606689 -0.977735,-80.936279 -1.032658,-80.749511 -1.955186,-80.969238 -2.306505,-80.474853 -2.547987,-80.299072 -2.767477,-80.310058 -3.019841,-80.057373 -2.943040,-79.947509 -2.789424,-79.859619 -2.877207,-80.057373 -3.381823,-80.321044 -3.414724,-80.716552 -3.677891,-81.024169 -4.083452,-81.287841 -4.302591,-81.309814 -4.773520,-81.046142 -5.058114,-81.188964 -5.069057,-81.123046 -5.276947,-80.848388 -5.714379,-81.057128 -5.790896,-81.134033 -6.085935,-80.068359 -6.642782,-79.694824 -7.155399,-79.584960 -7.493196,-79.189453 -7.449624))'

library(rgbif)
bat <-occ_search(scientificName = 'Chiroptera', geometry = polygon)

######################################
# Create matrix for latitude and longitude

sp.names <- strsplit(bat$data$name,"[ ]") ##Separe genera from sp.

data <- matrix(0,nrow=length(sp.names),ncol=4)
colnames(data) <- c("Genera","Specie","Lon","Lat")

for (i in 1:length(data[,1])){
  data[i,1] <- sp.names[[i]][1]
  data[i,2] <- sp.names[[i]][2]
  data[i,3] <- bat$data$decimalLongitude[i]
  data[i,4] <- bat$data$decimalLatitude[i]
} # Organize the data 

data

# remove generas without species.
p.na <- which(is.na(data[,2])==T)
data.no.na <- data[-p.na,]

data.no.na <- as.data.frame(data.no.na)

#####################################
# Create second matrix

species <- paste(data.no.na$Genera,data.no.na$Specie,sep=" ")
occ_dist <- paste(data.no.na$Lon,data.no.na$Lat,sep=" ")

species.unic <- unique(species)

data2 <- matrix(0,nrow=length(species),ncol=2)

data2[,1] <- species
data2[,2] <- occ_dist
colnames(data2) <- c("Sp","Occ")

data2 <- as.data.frame(data2)

n.sp <- 0:(length(species.unic)-1)

###################################
# Write xyd file 

write(paste("spp",as.character(length(species.unic),sep=" ")),file = "file.xyd")
write("nocommas",file = "file.xyd",append = T,sep = "\n")
write("xydata",file = "file.xyd",append=T,sep = "\n")
write(" ",file = "file.xyd",append = T,sep = "\n")

for (i in 1:length(species.unic)){
  title <- paste("sp",n.sp[i],sep=" ")
  title <- paste(title,"[")
  title <- paste(title,species.unic[i])
  title <- paste(title,"]")
  ## Create the species title in this way

  write(title,"file.xyd",append=T,sep="\n") ##Write the species title
  write(as.character(data2$Occ[data2$Sp==species.unic[i]]),file="file.xyd",append=T,sep="\n")
  ##Finally wrtie all occurences of the current species

}


