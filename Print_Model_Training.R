par(mfrow = c(2,2))
plot.new()
legend("center", legend=c("Best model","Average Model", "Worst Model", "Standard Deviation"),col=c("blue", "red", "darkgreen", "black"), lty = c(6,1,6,1), lwd = c(2,3,2,2), cex =1.5)

# Plot Q-Learning Model Tranining reward
plot(0,0,type = "l", ylim = c(0,200), xlim = c(1,400), main = "Model Training\nQ-Learning", xlab = "Episodes", ylab = "Reward")
q <- evolution("QL/Scores/SCR_QL__", 0:49, 400, ".csv", 2)
polygon(c(1:400,rev(1:400)), c(q$desvpos, rev(q$desvneg)), col = "grey")
lines(1:400, q$custos, ylim = c(0,200), xlim = c(1,400), type = "l", col = "red", lwd = 3)
box()
lines(1:400, q$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:400, q$desvmin, col = "darkgreen", pch = 2, lty = 6)

# Plot Deep Learning Model Tranining reward
plot(0,0,type = "l", ylim = c(0,200), xlim = c(1,25), main = "Model Training\nDeep Learning", xlab = "Epochs", ylab = "Reward")
d <- evolution("DL/Scores/SCR_DL_8_", 0:49, 25, ".csv",2)
polygon(c(1:25,rev(1:25)), c(d$desvpos, rev(d$desvneg)), col = "grey")
lines(1:25, d$custos, ylim = c(0,200), xlim = c(1,25), type = "l", col = "red", lwd = 3)
box()
lines(1:25, d$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:25, d$desvmin, col = "darkgreen", pch = 2, lty = 6)

# Plot Genetic Programming Model Training reward
temp <- c(0,1,2,7,8,9,14,15,16,21,22,23,28,29,30,35,36,37,42,43)

plot(0,0,type = "l", ylim = c(0,200), xlim = c(1,300), main = "Model Training\nGenetic Programming", xlab = "Generations", ylab = "Reward")
g <- evolution("GP/Log_Fitness/FIT_GP_20_", temp, 300, ".txt",2)
polygon(c(1:300,rev(1:300)), c(g$desvpos, rev(g$desvneg)), col = "grey")
lines(1:300, g$custos, ylim = c(0,300), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:300, g$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:300, g$desvmin, col = "darkgreen", pch = 2, lty = 6)

# Plot Q-Learning Model Tranining
plot(0,0,type = "l", ylim = c(0,200), xlim = c(1,400), main = "Model Training\nQ-Learning", xlab = "Episodes", ylab = "Reward")
q <- evolution("QL/Scores/SCR_QL__", 0:49, 400, ".csv", 2)
polygon(c(1:400,rev(1:400)), c(q$desvpos, rev(q$desvneg)), col = "grey")
lines(1:400, q$custos, ylim = c(0,200), xlim = c(1,400), type = "l", col = "red", lwd = 3)
box()
lines(1:400, q$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:400, q$desvmin, col = "darkgreen", pch = 2, lty = 6)

# Plot Deep Learning Model Tranining
plot(0,0,type = "l", ylim = c(0,200), xlim = c(1,25), main = "Model Training\nDeep Learning", xlab = "Epochs", ylab = "Reward")
d <- evolution("DL/Scores/SCR_DL_8_", 0:49, 25, ".csv",2)
polygon(c(1:25,rev(1:25)), c(d$desvpos, rev(d$desvneg)), col = "grey")
lines(1:25, d$custos, ylim = c(0,200), xlim = c(1,25), type = "l", col = "red", lwd = 3)
box()
lines(1:25, d$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:25, d$desvmin, col = "darkgreen", pch = 2, lty = 6)

# Plot Q-Learning Model Tranining time
plot(0,0,type = "l", ylim = c(0,6), xlim = c(1,400), main = "Model Time Training\nQ-Learning", xlab = "Episodes", ylab = "Time (ms)")
q <- evolution("QL/Scores/SCR_QL__", 0:49, 400, ".csv", 3)
polygon(c(1:400,rev(1:400)), c(q$desvpos, rev(q$desvneg))*1000, col = "grey")
lines(1:400, q$custos*1000, ylim = c(0,200), xlim = c(1,400), type = "l", col = "red", lwd = 3)
box()
lines(1:400, q$desvmax*1000, col = "blue", pch = 2, lty = 6)
lines(1:400, q$desvmin*1000, col = "darkgreen", pch = 2, lty = 6)

# Plot Deep Learning Model Tranining time
plot(0,0,type = "l", ylim = c(2,5), xlim = c(1,25), main = "Model Time Training\nDeep Learning", xlab = "Epochs", ylab = "Time (s)")
d <- evolution("DL/Scores/SCR_DL_8_", 0:49, 25, ".csv",3)
polygon(c(1:25,rev(1:25)), c(d$desvpos, rev(d$desvneg)), col = "grey")
lines(1:25, d$custos, ylim = c(2,5), xlim = c(1,25), type = "l", col = "red", lwd = 3)
box()
lines(1:25, d$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:25, d$desvmin, col = "darkgreen", pch = 2, lty = 6)

# Plot Genetic Programming Model Training Time
temp <- c(0,1,2,7,8,9,14,15,16,21,22,23,28,29,30,35,36,37,42,43)

plot(0,0,type = "l", ylim = c(40,140), xlim = c(1,300), main = "Model Time Training\nGenetic Programming", xlab = "Generations", ylab = "Time (s)")
g <- evolution("GP/Log_Fitness/FIT_GP_20_", temp, 300, ".txt",3)
polygon(c(1:300,rev(1:300)), c(g$desvpos, rev(g$desvneg)), col = "grey")
lines(1:300, g$custos, ylim = c(40,140), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:300, g$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:300, g$desvmin, col = "darkgreen", pch = 2, lty = 6)
