library(raster)
library(rgdal)
lats <- c(11.76168693)
lons <- c(76.5789076)
ras.files <- Sys.glob("/home/shashank/Projects/general/rainfall_data_imd/2021/*.tif")
bn <- strsplit(basename(ras.files),".tif")
ras.fle <- ras.files[bn>=20200101 && bn<= 20211231]


in.dates <- as.Date(basename(ras.fle), '%Y%m%d')

m <- length(lats)
n <- length(ras.fle)
out.file <- '/home/shashank/Projects/1117/Mundra/csv/BCH2.csv'
rf.vals <- c()
for(i in 1:n){
  ras <- raster(ras.fle[i])
  rf.val <- extract(ras, cbind(lons, lats))
  rf.vals <- append(rf.vals, rf.val)
  print(i)
}

out.df <- data.frame(Date = in.dates, Rainfall = round(rf.vals,2))
write.csv(out.df, out.file, row.names = F)