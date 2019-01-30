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

rasterOptions(tmpdir="/home/projects/data/tmp", tmptime=24, progress="text",
  timer=T, overwrite=T, chunksize=2e+08)
showTmpFiles()
removeTmpFiles(h=0)

#####################################################################################
# 2017.07.04 ETa, NDVI (over Ghana for Peter)
#####################################################################################
gha <- getData("GADM", country="GHA", level=0)
tmp <- fews[varCode=="ndvi_west" & date=="2017-03-01", raster(raster, crs=last(proj))]
tmp1 <- fews[varCode=="eta" & date=="2017-03-01", raster(raster, crs=last(proj))]
minValue(tmp)
minValue(tmp1)
NAvalue(tmp1)
maxValue(tmp)
maxValue(tmp1)
tmp <- crop(tmp, gha)
tmp1 <- crop(tmp1, gha)
tmp[tmp > 200] <- NA
tmp[tmp==0] <- NA
tmp <- (tmp - 100) / 100

png("./out/gha-ndvi-eta_2017.03.d1.png",
  width=7, height=3.8, units="in", res=220, pointsize=8)

print(spplot(tmp, col.regions=pal.ndvi,
  xlab=list("FEWS/USGS eMODIS C6 NDVI\nMarch 2017, dekad-1 (-1,1 index)", cex=.8)),
  split=c(1,1,2,1), more=T)

print(spplot(tmp1, col.regions=pal.et,
  xlab=list("FEWS/USGS ETa\nMarch 2017, dekad-1 (mm)", cex=.8)),
  split=c(2,1,2,1), more=F)

dev.off()

#####################################################################################

