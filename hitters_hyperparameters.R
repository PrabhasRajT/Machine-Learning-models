FLAGS <-flags(
  flag_numeric("batch_size", 50),
  flag_numeric("units1", 16),
  flag_numeric("units2", 16),
  flag_string("activation_function", "relu"),
  flag_numeric("learning_rate", 0.01)
)
library(keras)
model1 <-keras_model_sequential() %>%
  layer_dense(units = FLAGS$units1, activation = FLAGS$activation_function,
              input_shape=dim(hittersnewdata)[2]) %>%
  layer_dense(units = FLAGS$units2,activation=FLAGS$activation_function ) %>%
  layer_dense(units = 1)

model1 %>% compile(loss = "mse",optimizer =optimizer_adam(learning_rate=FLAGS$learning_rate))

model1 %>% fit(as.matrix(hittersnewdata),
              hitters_train_y,
              batch_size=FLAGS$batch_size,
              epochs = 50,
              validation_data=list(as.matrix(hitters_val_x),hitters_val_y), verbose=2)
