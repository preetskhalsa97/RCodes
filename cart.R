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

stevensForest=randomForest(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst,data=train,nodesize=25,ntree=200)

predictForest=predict(stevensForest,newdata=test)

#confusion maatrix to check accuracy
table(test$Reverse,predictForest)

#cross validation==> k fold validation 

## Install cross-validation packages
install.packages("caret")
library(caret)
install.packages("e1071")
library(e1071)

# Define cross-validation experiment
numFolds = trainControl( method = "cv", number = 10 )
cpGrid = expand.grid( .cp = seq(0.01,0.5,0.01)) 

# Perform the cross validation
train(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method = "rpart", trControl = numFolds, tuneGrid = cpGrid )

# Create a new CART model
StevensTreeCV = rpart(Reverse ~ Circuit + Issue + Petitioner + Respondent + LowerCourt + Unconst, data = Train, method="class", cp = 0.18)

# Make predictions
PredictCV = predict(StevensTreeCV, newdata = Test, type = "class")
table(Test$Reverse, PredictCV)
