sel_best_game <- function(name, rang, iter, type_file, cl, name1){
  aux <- matrix(nrow = iter, ncol = length(rang))
  for (i in 1:length(rang)){
    a <- read.csv(paste(name, as.character(rang[i]), type_file, sep= ""), header = FALSE, quote = "")
    for (j in 1:iter){
      aux[j,i] <- as.numeric(a[j,cl])
    }
  }
  aux1 <- matrix(nrow = length(rang), ncol = 1)
  for (j in 1:length(rang)){
    aux1[j] = sum(aux[,j], na.rm = TRUE)
  }

  return(read.csv(paste(name1, as.character(rang[which(aux1 == max(aux1))]), "_", as.character(1), ".csv", sep= ""), header = FALSE, quote = ""))
}
