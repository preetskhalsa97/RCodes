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
Coloring points by region and plotting a regression line
"""
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

