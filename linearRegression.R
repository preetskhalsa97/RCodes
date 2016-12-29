model1=lm(Price~AGST,data=wine)
summary(model1) #won't give Standard Deviation
SSE=sum((model1$residuals)^2)
#Multiple Regression
model2=lm(var1~var2+var3,data=wine)
model3=lm(var1 . ,data=wine) #will use all other variables as independent and construct the model
#with the test data
predict_test=predict(ourModel,newdata=testData)
SSE=sum((testData$var1-predict_test)^2)
SST=sum((testData$var1-mean(trainData,na.rm=TRUE))^2)
rSquare=1-(SSE/SST)

#USING STEP
step(model2)

#timeSeries
library(zoo)
varLag2=lag(zoo(fluTrain$var),-2,na.pad=TRUE)
fluTrain$varLag2=coredata(varLag2)

