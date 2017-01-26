#ggplot 2 consists of three elements- 1. data 2. aesthetic maping 3. geometric objects

library(ggplot2)
scatterplot=ggplot(who,aes(x=GNI,y=FertilityRate))
#selecting the geometric object
scatterplot+geom_point()
scatterplot+geom_line()
scatterplot+geom_point(color="blue",size=3,shape=17) #17 ccorrespond to triangles 
#color="darkred",shape=8==> stars
"""
All shapes available @http://www.cookbook-r.com/Graphs/Shapes_and_line_types/

Available colors can be checked by typing in R console- colors()
"""

#Giving Title
scatterplot+geom_point(color="blue",size=3,shape=17) +ggtitle("Title")

#saving the scatterplot
plot=scatterplot+geom_point(color="blue",size=3,shape=17) +ggtitle("Title")
pdf("myPlot.pdf")
print (plot)
dev.off()

"""
Coloring points by region and plotting a regression line"""
ggplot(who,aes(x=GNI,y=FertilityRate,color=Region))+geom_point() +xlab("hfyhtgrfe") #x axis label
#adding regression line to the plot 
ggplot(who,aes(x=GNI,y=FertilityRate,color=Region))+geom_point() + stat_smooth(method=lm)
#By default, ggplot will draw 95% confidence interval shaded around the line 
ggplot(who,aes(x=GNI,y=FertilityRate,color=Region))+geom_point() + stat_smooth(method=lm, level=0.99) #Now, 99% confidence intterval 
ggplot(who,aes(x=GNI,y=FertilityRate,color=Region))+geom_point() + stat_smooth(method=lm, se=FALSE) #now, no confidence interval shaded
ggplot(who,aes(x=GNI,y=FertilityRate,color=Region))+geom_point() + stat_smooth(method=lm, se=FALSE, color="red") #changing color of the regression line

#we can roughly see the relation between x and y axis by x=GNI,y=log(FertilityRate)

#changing the order of variables on the x axis
# Create our plot
ggplot(WeekdayCounts, aes(x=Var1, y=Freq)) + geom_line(aes(group=1))  

# Make the "Var1" variable an ORDERED factor variable
WeekdayCounts$Var1 = factor(WeekdayCounts$Var1, ordered=TRUE, levels=c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday","Saturday"))

# Try again:
ggplot(WeekdayCounts, aes(x=Var1, y=Freq)) + geom_line(aes(group=1))

#Making Heat Maps
DayHourCounts = as.data.frame(table(mvt$Weekday, mvt$Hour))

DayHourCounts$Hour = as.numeric(as.character(DayHourCounts$Var2))

ggplot(DayHourCounts, aes(x=Hour, y=Freq)) + geom_line(aes(group=Var1)) #Var1-> day of the week ==> group by days==> we get 7 lines
ggplot(DayHourCounts, aes(x=Hour, y=Freq)) + geom_line(aes(group=Var1,color=Var1)) #diff colors for diff days 

# Make a heatmap:
ggplot(DayHourCounts, aes(x = Hour, y = Var1)) + geom_tile(aes(fill = Freq))

# Change the color scheme
ggplot(DayHourCounts, aes(x = Hour, y = Var1)) + geom_tile(aes(fill = Freq)) + scale_fill_gradient(name="Total MV Thefts", low="white", high="red") + theme(axis.title.y = element_blank())

"""
Geographical Maps
"""
# Install and load two new packages:
install.packages("maps")
install.packages("ggmap")
library(maps)
library(ggmap)

# Load a map of Chicago into R:
chicago = get_map(location = "chicago", zoom = 11)

# Look at the map
ggmap(chicago)

# Plot the first 100 motor vehicle thefts:
ggmap(chicago) + geom_point(data = mvt[1:100,], aes(x = Longitude, y = Latitude))

# Round our latitude and longitude to 2 digits of accuracy, and create a crime counts data frame for each area:
LatLonCounts = as.data.frame(table(round(mvt$Longitude,2), round(mvt$Latitude,2)))

str(LatLonCounts)

# Convert our Longitude and Latitude variable to numbers:
LatLonCounts$Long = as.numeric(as.character(LatLonCounts$Var1))
LatLonCounts$Lat = as.numeric(as.character(LatLonCounts$Var2))

# Plot these points on our map:
ggmap(chicago) + geom_point(data = LatLonCounts, aes(x = Long, y = Lat, color = Freq, size=Freq))

# Change the color scheme:
ggmap(chicago) + geom_point(data = LatLonCounts, aes(x = Long, y = Lat, color = Freq, size=Freq)) + scale_colour_gradient(low="yellow", high="red")

# We can also use the geom_tile geometry
ggmap(chicago) + geom_tile(data = LatLonCounts, aes(x = Long, y = Lat, alpha = Freq), fill="red")

#--------------------------------------------------------------#
murders = read.csv("murders.csv")

str(murders)

# Load the map of the US
statesMap = map_data("state")

str(statesMap)

# Plot the map:
ggplot(statesMap, aes(x = long, y = lat, group = group)) + geom_polygon(fill = "white", color = "black") 

# Create a new variable called region with the lowercase names to match the statesMap:
murders$region = tolower(murders$State)

# Join the statesMap data and the murders data into one dataframe:
murderMap = merge(statesMap, murders, by="region")
str(murderMap)

# Plot the number of murder on our map of the United States:
ggplot(murderMap, aes(x = long, y = lat, group = group, fill = Murders)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black", high = "red", guide = "legend")

# Plot a map of the population:
ggplot(murderMap, aes(x = long, y = lat, group = group, fill = Population)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black", high = "red", guide = "legend")

# Create a new variable that is the number of murders per 100,000 population:
murderMap$MurderRate = murderMap$Murders / murderMap$Population * 100000

# Redo our plot with murder rate:
ggplot(murderMap, aes(x = long, y = lat, group = group, fill = MurderRate)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black", high = "red", guide = "legend")

# Redo the plot, removing any states with murder rates above 10:
ggplot(murderMap, aes(x = long, y = lat, group = group, fill = MurderRate)) + geom_polygon(color = "black") + scale_fill_gradient(low = "black", high = "red", guide = "legend", limits = c(0,10))



