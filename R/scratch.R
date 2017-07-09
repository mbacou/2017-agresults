#####################################################################################
# AgResults
#####################################################################################

library(raster)
library(data.table)
library(stringr)
library(viridis)
library(tmap)

setwd("~/Projects/2017-agresults")
load("./tmp/2017-agresults.RData")

#####################################################################################
# 2017.07.04 ETa, NDVI (over Ghana for Peter)
#####################################################################################
gha <- getData("GADM", country="GHA", level=0)
tmp <- fews[varCode=="ndvi_west" & status==T, raster(last(raster), crs=last(proj))]
tmp1 <- fews[varCode=="eta" & status==T, raster(last(raster), crs=last(proj))]
maxValue(tmp)
hist(tmp[tmp])
tmp <- crop(tmp, gha)
tmp1 <- crop(tmp1, gha)
tmp[tmp > 200] <- NA
tmp[tmp==0] <- NA
tmp <- (tmp - 100) / 100
plot(tmp)
spplot(tmp)
plot(tmp, legend=T)

png("../2017-agra-aasr/out/gha-ndvi-eta_2017.06.d2.png",
  width=7, height=3.8, units="in", res=220, pointsize=8)

print(spplot(tmp, col.regions=pal.ndvi,
  xlab=list("FEWS/USGS NDVI\nJune 2017, dekade 2 (-1,1 index)", cex=.8)),
  split=c(1,1,2,1), more=T)

print(spplot(tmp1, col.regions=pal.et,
  xlab=list("FEWS/USGS ETa\nJune 2017, dekade 2 (mm)", cex=.8)),
  split=c(2,1,2,1), more=F)

dev.off()

#####################################################################################

