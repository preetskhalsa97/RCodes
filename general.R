#Creating Vectors in R
a=c(1,2,3,4)
a<-c(1,2,3,4)
a=seq(1,4)

#Making aa DataFrame
country=c("India","China")
lifeExpectancy=c(65,67)
countryData=data.frame(country,lifeExpectancy)
#Adding another column 
countryData$population=c(1000,2000)

#Combining data frames with same heads
allCountryData=rbind(countryData,newCountryData)

#reading csv
getwd()
setwd("AnalyticsEdge/W01")
who=read.csv("who.csv")
#structure
str(who)
#summary
summary(who)
#number of rows
nrows(who)
#names of COLUMNS
names(who)
#removing all rows with NA 
who=na.omit(who)

#subset
whoAsia=subset(who,Region=="Asia")

#saving the csv created
write.csv(whoAsia,"WHO_Asia.csv")

mean(who$Under15)
min(who$Under15)
max(who$Under15)

#***Finding reqd index- minimum who$Under15
which.min(who$Under15)
#extracting a particular index of variable
who$country[which.min(who$Under15)]

#To get index of a particular value 
match("Caviar",usda$Description)

#PLOTS
plot(data$x,data$y,col="red")
lines(data$x,data$y,col="green")

plot(x2014$time,x2014$Rating,axes=FALSE,xlab = "#Week",ylab = "Relative search Frequency")
axis(side=1, at=c(1:51))
axis(side=2, at=c(1:100))
box()
lines(x2014$time,x2014$Rating)
lines(x2015$time,x2015$Rating,col="blue")
lines(x2016$time,x2016$Rating,col="red")
text(26,92,"red-2016,blue-2015")
text(26,87,"black-2014")

#vertical line
abline(v=4,lwd=2)

#BOXPLOT
boxplot(who$lifeExpectancy ~ who$Region)

#HISTOGRAM
hist(who$CellularSubscribers)

#Getting Limited Variables 
who[c("Country","GNI","FertilityRate")]

#TABLES
table(who$Region)
sort(table(who$Region))
table(usda$highSodium,usda$highFat) #sodium values appearing vertically 

#TAPPLY
tapply(who$Over60,who$Region,mean,na.rm=TRUE) #==> Splits data by Region and finds mean of who$Over60

#************
highSodium=usda$sodium > mean(usda$sodium, na.rm=TRUE) #Returns TRUE and Falsa
#to get 0 or 1 instead of False/True
usda$highSodium=as.numeric(usda$sodium > mean(usda$sodium, na.rm=TRUE))

#DATES
#converting y/m/d to y-m-d
ibm$date=as.Date(ibm$date,"%m/%d/%y")

#checking for NA==> can also be checked roughly through summary
is.na(cps$married) #returns a vector ==> TRUE if NA, else FALSE





