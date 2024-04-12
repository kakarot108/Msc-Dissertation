### --------------------------------------------- SPEI CONTINUE ----------------------------------------

waterbal <- precep - pet # CLREATING A VARIABLE BY SUBTRACTING PET BY PRECIPITATION ----------------
#waterbal <- mask(waterbal, Jharkhand)
### Extracting Precipitation Data using "Extract" function and similar can be done using "Cellstats"
precep_ext <- cellStats(precep, Jhmean, na.rm = TRUE)

############################################################################################################
#############################-------- SPEI CALCULATION ----------------#####################################
##                                      1st PROCEDURE
## Change the function SPEI so it outputs a numeric vector from fitted
## Pass Scale Value
rstSPEI_3 <- calc(waterbal,
                fun = function(x, scale = 3,    ### 3 MONTHS
                na.rm = T) as.numeric((spei(x,
                scale = scale, na.rm = T))$fitted))

rstSPEI_6 <- calc(waterbal,
                fun = function(x, scale = 6,    ### 6 MONTHS
                na.rm = T) as.numeric((spei(x,
                scale = scale, na.rm = T))$fitted))

rstSPEI_9 <- calc(waterbal,
                fun = function(x, scale = 9,    ### 9 MONTHS
                na.rm = T) as.numeric((spei(x,
                scale = scale, na.rm = T))$fitted))

rstSPEI_12 <- calc(waterbal,
                fun = function(x, scale = 12,   ### 12 MONTHS
                na.rm = T) as.numeric((spei(x,
                scale = scale, na.rm = T))$fitted))
