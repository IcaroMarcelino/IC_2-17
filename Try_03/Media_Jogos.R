balancing_plot <- function(name, rang, iter, type_file, cl){
  aux <- matrix(nrow = iter, ncol = length(rang)*10)
  est <- c(rep(0,each=iter))
  desvpos <- c(rep(0,each=iter))
  desvneg <- c(rep(0,each=iter))
  desvmax <- c(rep(0,each=iter))
  desvmin <- c(rep(0,each=iter))
  for (i in 1:length(rang)){
    for (k in 1:10){
      count = 1
      a <- read.csv(paste(name, as.character(rang[i]), "_", as.character(k), type_file, sep= ""), header = FALSE, quote = "")
      for (j in 1:iter){
        if(nrow(a)==j){
          break
        }
          aux[j,k+(i-1)*10] <- as.numeric(a[j,cl])
      }
    }
  }
  for (j in 1:iter){
    est[j] <- mean(as.numeric(aux[j,]), na.rm = TRUE)
    desvpos[j] <- sqrt(var(aux[j,], na.rm = TRUE))
    desvneg[j] <- sqrt(var(aux[j,], na.rm = TRUE))
    desvmax[j] <- max(aux[j,], na.rm = TRUE)
    desvmin[j] <- min(aux[j,], na.rm = TRUE)
  }
  return(list(custos = est, desvneg = est - desvneg, desvpos = desvpos + est, desvmax = desvmax, desvmin = desvmin))
}


