#installing package to split data randomly into training and testing samples
install.packages("caTools")
#loading for using
library(caTools)

sample=sample.split(quality$poorCare,SplitRatio=0.75)  #first arg- outcome variable, second arg- percentage of the data we want in the training set
#Also, ensures outcome variable is balanced in each piece==> test set representative of training set

sample # Vector containing TRUE/FALSE, TURE--> we include that obs in the training set
qTrain=subset(q,sample==TRUE)
qTest=subset(q,sample==FALSE)

#CREATING A LOGISTIC REGRESSSION
#glm==> Generalised Linear Model
qLog=glm(poorCare~officeVisits+narcotics,data=qTrain,family=binomial)
#Making predictions on the training set 
predictTrain=predict(qLog,type="response") #type="response"==> tells the predict function to give probabilities

#computing average prediction for each true outcome 
tapply(predictTrain,qTrain$poorCare,mean)
# will give two values for 0 and 1 resp. lets say value of for 1 is theta==> 
#probability that it is predicting True for actually true case on an average = theta

#LOOK INTO THE THEORY IN NOTEBOOK

#CONFUSION/ CLASSIFICATION TABLE
tValue=0.5
table(qTrain$poorCare,predictTrain>0.5)

#GENERATING ROC CURVE
install.packages("ROCR")
library(ROCR)

ROCRpred=prediction(predictTrain,qTrain$poorCare)

#plotting the curve
ROCRperf=performance(ROCRpred,"tpr","fpr") #True Positive Rate, False Positive Rate ==> labelling x and y axis
plot(ROCRperf,colorize=TRUE,print.cuttoffs.at=seq(0,1,0.1), text.adj=c(-0.2,1.7)) #Marking on the RHS y- axiss shows the corresponding threshold value

predictTest=predict(qLog,type="Response",newData=qTest)



