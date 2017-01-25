#heirarchical clustering 

distances=dist(movies[2:20],method="euclidean")
clusterMovies=hclust(distances,method="ward.D") #ward cares about distance between clusters using centroid method 

#plotting dendogram
plot(clusterMovies)

#clustering into 10 groups 
clusterGroups=cutree(clusterMovies,k=10) 

#one command for each cluster
colMeans(subset(movies[2:20], clusterGroups == 1))

"""A more advanced approach uses the 'split' and 'lapply' functions. The following command will split the data into subsets based on the clusters:

spl = split(movies[2:20], clusterGroups)

Then you can use spl to access the different clusters, because

spl[[1]]

is the same as

subset(movies[2:20], clusterGroups == 1)

so colMeans(spl[[1]]) will output the centroid of cluster 1. But an even easier approach uses the lapply function. The following command will output the cluster centroids for all clusters:

lapply(spl, colMeans)

The lapply function runs the second argument (colMeans) on each element of the first argument (each cluster subset in spl). So instead of using 19 tapply commands, or 10 colMeans commands, we can output our centroids with just two commands: one to define spl, and then the lapply command.

Note that if you have a variable called 'split' in your current R session, you will need to remove it with rm(split) so that you can use the split function.

"""

#to see distribution of action movies across clusters
tapply(movies$Action, clusterGroups,mean)

clustur2=subset(movies,clusterGroups==2)

clustor2$Title[1:10]
