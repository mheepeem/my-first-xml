library(tidyverse)
library(caret)
library(mlbench)

data("PimaIndiansDiabetes")

# complete / not null?
df <- PimaIndiansDiabetes
mean(complete.cases(df))
glimpse(df)
# target / label?
diabetes

# 1. split data
set.seed(10)
id <- createDataPartition(y = df$diabetes,
                          p = 0.8,
                          list = FALSE)

train_df <- df[id, ]
test_df <- df[-id, ]

# 2. train model
# model-01
set.seed(10)
# classProbs & summaryFunction need for ROC
ctrl <- trainControl(
  method = "cv",
  number = 5,
  classProbs = TRUE,
  summaryFunction = twoClassSummary,
  verboseIter = TRUE
)

rf_model <- train(
  diabetes ~ .,
  data = train_df,
  method = "rf",
  metric = "ROC",
  preProcess = c("center", "scale"),
  trControl = ctrl
)

# model-02
library(rpart.plot)
set.seed(10)
myGrid <- data.frame(cp = seq(0.001, 0.3, by = 0.005))
tree_model <- train(diabetes ~ .,
                    data = train_df,
                    method = "rpart",
                    tuneGrid = myGrid,
                    trControl = trainControl(
                      method = "cv",
                      number = 5
                    ))

rpart.plot(tree_model$finalModel)

# model-03
set.seed(10)
myGrid <- data.frame(mtry = 2:7)
rf_model <- train(diabetes ~ .,
                    data = train_df,
                    method = "rf",
                    metric = "AUC",
                    preProcess = c("center", "scale"),
                    tuneGrid = myGrid,
                    trControl = trainControl(
                      method = "cv",
                      number = 5,
                      verboseIter = TRUE,
                      classProbs = TRUE,
                      summaryFunction = prSummary
                    ))

# 3. test model
# model-01
p <- predict(rf_model, newdata = test_df)
mean(p == test_df$diabetes)

confusionMatrix(p, 
                test_df$diabetes, 
                mode = "prec_recall",
                positive = "pos")

# model-03
p <- predict(rf_model, newdata = test_df)
confusionMatrix(p,
                test_df$diabetes,
                mode = "prec_recall",
                positive = "pos")
