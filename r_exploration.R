#Must install install.packages("RSQLite")
#Load package
library("RSQLite")

#Connect to DB
drv = dbDriver("SQLite")
dbFp = "C:/Users/eotles/Desktop/test.sqlite"
con = dbConnect(drv, dbFp)

#get Data
data = dbGetQuery(con, "SELECT cc1, Accuity, DoW, ArrMode, Throughput FROM i2_s1 INNER JOIN tDiff ON i2_s1.CSN=tDiff.CSN")

#split
cc1 = data$cc1
acc = data$Accuity
dow = data$DoW
arm = data$ArrMode
tp = data$Throughput

#dummy marix encoding
dm_cc1 = model.matrix(~cc1)
dm_dow = model.matrix(~dow)
dm_arm = model.matrix(~arm)

#linear models
mod = lm(tp ~ dm_cc1*acc)