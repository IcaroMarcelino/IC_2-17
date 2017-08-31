sel_best <- function(name, rang, iter, type_file, cl){
  aux <- matrix(nrow = iter, ncol = length(rang))
  for (i in 1:length(rang)){
    a <- read.csv(paste(name, as.character(rang[i]), type_file, sep= ""), header = FALSE, quote = "")
    for (j in 1:iter){
      aux[j,i] <- as.numeric(a[j,cl])
    }
  }
  aux1 <- matrix(nrow = length(rang), ncol = 1)
  for (j in 1:length(rang)){
    aux1[j] = sum(aux[,j])
  }
  
  return(read.csv(paste(name, as.character(rang[which(aux1 == max(aux1))]), type_file, sep= ""), header = FALSE, quote = ""))
}
