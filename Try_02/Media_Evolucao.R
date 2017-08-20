evolution <- function(name, rang, iter, type_file, cl){
  aux <- matrix(nrow = iter, ncol = length(rang))
  est <- c(rep(0,each=iter))
  desvpos <- c(rep(0,each=iter))
  desvneg <- c(rep(0,each=iter))
  desvmax <- c(rep(0,each=iter))
  desvmin <- c(rep(0,each=iter))
  for (i in 1:length(rang)){
    a <- read.csv(paste(name, as.character(rang[i]), type_file, sep= ""), header = FALSE, quote = "")
    for (j in 1:iter){
      est[j] <- est[j] + as.numeric(a[j,cl]/length(rang))
      aux[j,i] <- as.numeric(a[j,cl])
    }
  }
  for (j in 1:iter){
    desvpos[j] <- sqrt(var(aux[j,]))
    desvneg[j] <- sqrt(var(aux[j,]))
    desvmax[j] <- max(aux[j,])
    desvmin[j] <- min(aux[j,])
  }
  return(list(custos = est, desvneg = est - desvneg, desvpos = desvpos + est, desvmax = desvmax, desvmin = desvmin))
}
