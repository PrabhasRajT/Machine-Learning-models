FLAGS <-flags(
  flag_numeric("batch_size", 32),
  flag_numeric("units1", 32),
  flag_numeric("units2", 32),
  flag_string("activation_function", "relu"),
  flag_numeric("learning_rate", 0.01),
  
)
library(keras)
model <-keras_model_sequential() %>%
  layer_dense(units = FLAGS$units1, activation = FLAGS$activation_function, input_shape=dim(x_train)[2]) %>%
  layer_dense(units = FLAGS$units2,activation=FLAGS$activation_function ) %>%
  layer_dense(units = 1, activation="sigmoid")

compile(loss = "binary_crossentropy",optimizer =optimizer_adam(lr=FLAGS$learning_rate)  , metrics="accuracy")

model %>% fit(as.matrix(x_train),
              y_train,
              batch_size=FLAGS$batch_size,
              epochs = 20,
              validation_data=list(as.matrix(x_test),y_test), verbose=2)
