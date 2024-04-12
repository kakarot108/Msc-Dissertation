#####################################################################################################
#                                         ARIDITY INDEX

Aridity <- (precep/pet)/31 ## Monthly

## Converting Monthly Data to Yearly datasets (total 372 layers that means 31 years data, the loop has
#                            to Run until 31)
yrly_Aridity <- Aridity[[1:31]] ## Memory Allocation
for(i in 1:31){
  print(i)
  j=i*12
  k = j - 11
  yrly_Aridity[[i]] <- calc(Aridity[[k:j]], fun = mean, na.rm =T) ## Converting 12 months to mean 1 layer
}

yrly_Aridity <- mask(yrly_Aridity, Jharkhand) ## Masking using Jharkhand Shapefile

yrly_Aridity_mean <- calc(yrly_Aridity11, fun = mean, na.rm=T)



yrly_Aridity11 <- yrly_Aridity*10
plot(yrly_Aridity11)

Aridity_M_ <- Aridity*10
Aridity_M_ <- mask(Aridity_M_, Jharkhand)
