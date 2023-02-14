FLAGS= flags( 
  flag_numeric("learning_rate", 0.01),
  flag_numeric("units1", 64),
  flag_numeric("units2", 64),
  flag_numeric("batch_size", 50),
  flag_string("activation_function", "relu")
  
)


library(keras)
model <-keras_model_sequential() %>%
  layer_dense(units = FLAGS$units1,input_shape=dim(cnt123_train_dtm)[2], 
              activation = FLAGS$activation_function) %>%
  layer_dense(units = FLAGS$units2,activation= FLAGS$activation_function) %>%
  layer_dense(units = 3, activation="softmax")

model %>% compile(loss = "sparse_categorical_crossentropy",
  optimizer=optimizer_adam(learning_rate=FLAGS$learning_rate), 
   metric = "accuracy")

model %>% fit(
  as.matrix(cnt123_train_dtm), cnt123_train_labels, epochs= 20,
  batch_size=FLAGS$batch_size, validation_data=list(as.matrix(cnt123_validation_dtm),
                                                    cnt123_validation_labels), verbose=2)



