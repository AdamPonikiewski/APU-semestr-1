rm(list=ls())
# Załaduj potrzebne pakiety
library(MASS)
library(mlr)

# Załaduj dane
data(Aids2, package = "MASS")

# Wybierz interesujące Cię kolumny (atrybuty)
Aids2 <- Aids2[, c("state", "sex", "age", "T.categ", "diag")]

# Zdefiniuj zadanie klasyfikacyjne
task <- makeClassifTask(data = Aids2, target = "diag")

# Zdefiniuj algorytm uczenia maszynowego
learner <- makeLearner("classif.C50")

# Podziel dane na zbiór treningowy i testowy
train_set <- sample(1:nrow(Aids2), nrow(Aids2)*0.8)
test_set <- setdiff(1:nrow(Aids2), train_set)

# Trenuj model na zbiorze treningowym
model <- train(learner, task, subset = train_set)

# Przetestuj model na zbiorze testowym
pred <- predict(model, task = task, subset = test_set)

# Przetestuj model na zbiorze testowym
pred <- predict(model, task = task, subset = test_set)
performance(pred, measures = list(mmce, acc))

