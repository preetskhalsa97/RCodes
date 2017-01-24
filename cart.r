#split the package into train and test using caTools first

# install packages- rpart and rpart.plot
stevensTree=rpart(Reverse~Circuit+Issue+Petitioner+Respondent+LowerCourt+Unconst,data=train,method="class",minbucket=25)
prp(stevensTree)
predictCART=predict(stevensTree,newdata = test, type="class")

#confusion matrix
table(test$Reverse,predictCART)

#Generating ROCR curve 
library(ROCR)
predictROC=(stevensTree,newdata=test) #not working? 
predictROC
pred=prediction(predictROC[,2],test$Reverse)
perf=performance(pred,"tpr","fpr")
 
 #RANDOM FOREST
#install and load randomForest

#here, it is a classification problem and we need factor variables for that 

train$Reverse=as.factor(train$Reverse)
test$Reverse=as.factor(test$Reverse)