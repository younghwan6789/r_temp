source("2_import_libraries.R")
source("3_read_files.R")
source("4_eda.R")
source("5_preprocessing.R")
source("6_modeling.R")
source("7_validation.R")
source("8_visualization.R")
source("utils.R")

################################################################################
# read files
################################################################################

################################################################################
# check data type
################################################################################
# str(df)
# dim(df)
# summary(df)
# sum(is.na(df))
# df[!complete.cases(df), ]

################################################################################
# preprocessing
################################################################################

################################################################################
# eda
################################################################################

################################################################################
# separate data
################################################################################
# 전체 데이터 준비
df_ready <- subset(df_combined_4, select = -c(datetime))

# 분할
sample_split <- sample.split(Y = df_ready, SplitRatio = 0.7)

train_set <- subset(x = df_ready, sample_split == TRUE)
test_set <- subset(x = df_ready, sample_split == FALSE)

train_x <- subset(train_set, select = -c(rent))
train_y <- subset(train_set, select = c(rent))

test_x <- subset(test_set, select = -c(rent))
test_y <- subset(test_set, select = c(rent))

################################################################################
# 다중 공선성 확인
################################################################################
vif_values <- vif(lm(rent ~ ., data = train_set))
print(vif_values)

################################################################################
# modeling
################################################################################
### ntree = 100
model_rf <- randomForest(rent ~ .,
  data = train_set, ntree = 100, type = "regression", importance = TRUE
)

### ntree = 500
model_rf <- randomForest(rent ~ .,
  data = train_set, ntree = 500, type = "regression", importance = TRUE
)

### ntree = 100
model_rf <- randomForest(rent ~ high_temperature + rainy + windy + no2_ppm + o3_ppm + co_ppm + so2_ppm + part_matter + ultra_part_matter + holiday,
  data = train_set, ntree = 100, type = "regression", importance = TRUE
)

### ntree = 500
model_rf <- randomForest(rent ~ high_temperature + rainy + windy + no2_ppm + o3_ppm + co_ppm + so2_ppm + part_matter + ultra_part_matter + holiday,
  data = train_set, ntree = 500, type = "regression", importance = TRUE
)

print(model_rf)
summary(model_rf)

################################################################################
# validation
################################################################################

## 예측
predicted_y <- predict(model_rf, test_x)
summary(train_set$rent)
summary(predicted_y)
summary(test_y$rent)
summary(origin_test_y$rent)


## MSE, MAE, MAPE 점수 확인
calculate_mse_mae_mape(test_y$rent, predicted_y)
## R-Squared 점수 확인 - 1일 수록 좋음
calculate_r_squared(predicted_y, test_y$rent)
## [시각화] 관련이 높은 변수 확인
varImpPlot(model_rf, type = 2, col = 1, cex = 1)

## [시각화] 잔차
view_residual_plot(test_y$rent, predicted_y)

################################################################################
# visualization
################################################################################