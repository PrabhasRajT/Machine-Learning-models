FLAGS= flags( 
  flag_numeric("learning_rate", 0.01),
  flag_numeric("units1", 32),
  flag_numeric("units2", 32),
  flag_numeric("batch_size", 32),
  flag_string("activation_function", "relu")
  
)

library(keras)
model <- keras_model_sequential() %>%
  layer_dense(units=FLAGS$units1, input_shape=dim(hcdsd_train_x)[2], activation=FLAGS$activation_function) %>%
  layer_dense(units=FLAGS$units2, activation=FLAGS$activation_function) %>%
  layer_dense(units=1, activation="sigmoid")

model %>% compile( loss="binary_crossentropy", 
                   optimizer=optimizer_adam(learning_rate=FLAGS$learning_rate), metric="AUC" )
model %>% fit (as.matrix(hcdsd_train_x), hcdsd_train_y, epochs=20, 
               batch_size=FLAGS$batch_size, 
               validation_data=list(as.matrix(hcdsd_val_x),hcdsd_val_y), 
               class_weight=list("0"=w_no, "1"=w_yes), verbose=2)