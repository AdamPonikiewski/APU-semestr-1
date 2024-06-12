rm(list = ls())
# Załaduj potrzebne pakiety
library(mlr)
library(ggplot2)

# Załaduj dane (zakładam, że Twoje dane są w formacie dataframe i nazywają się 'lodowki')
lodowki <- read.csv("C:/Users/aadam/Documents/jezykR-apu-inf-sem-1/mlr/zadanie 2/lodowki.csv", fileEncoding = "UTF-8")

# Sprawdź, czy kolumna 'status_opinii' istnieje
if ("status_opinii" %in% names(lodowki)) {
  # Jeśli istnieje, przekształć ją na czynnik
  lodowki$status_opinii <- as.factor(lodowki$status_opinii)
}

# Konwertuj kolumny 'nazwa' i 'ocena_klientow' na czynniki
lodowki$nazwa <- as.factor(lodowki$nazwa)
lodowki$ocena_klientow <- as.factor(lodowki$ocena_klientow)

# Utwórz zadanie klasyfikacyjne
task <- makeClassifTask(data = lodowki, target = "ocena_klientow")

# Utwórz listę algorytmów do porównania
learners_list <- list(
  makeLearner("classif.rpart", id = "CART"),
  makeLearner("classif.C50", id = "C5.0"),
  makeLearner("classif.randomForest", id = "RandomForest"),
  makeLearner("classif.svm", id = "SVM"),
  makeLearner("classif.logreg", id = "LogisticRegression")
)

# Ustaw strategię resampling
rdesc <- makeResampleDesc("CV", iters = 5L)

# Porównaj modele
benchmark_results <- benchmark(learners = learners_list, tasks = task, resamplings = rdesc)

# Wyświetl wyniki
print(benchmark_results)

# Wykreśl wyniki
plot_benchmark(benchmark_results)

