remove(g,q,d)
dev.off()
png(filename = paste("Try_0", ex ,"/Model_Training_TRY",ex,".png", sep = ''), height = 520, width = 750)
par(mfrow = c(2,2))

# Plot Deep Learning Model Tranining reward
plot(0,0,type = "l", ylim = c(0,200), xlim = c(1,25), main = "Model Training\nDeep Learning", xlab = "Epochs", ylab = "Reward")
d <- evolution(paste("Try_0", ex, "/DL/Scores/SCR_DL_8_", sep = ""), 0:49, 25, ".csv",2)
polygon(c(1:25,rev(1:25)), c(d$desvpos, rev(d$desvneg)), col = "grey")
lines(1:25, d$custos, ylim = c(0,200), xlim = c(1,25), type = "l", col = "red", lwd = 3)
box()
lines(1:25, d$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:25, d$desvmin, col = "darkgreen", pch = 2, lty = 6)
d <- sel_best(paste("Try_0", ex, "/DL/Scores/SCR_DL_8_", sep = ""), 0:49, 25, ".csv",2)
lines(1:length(d$V2), d$V2, col = "orange", pch = 2, lwd = 2)

# Plot Genetic Programming Model Training reward
# TRY1
temp <- c(0:31,33:49)
# TRY2
temp <- c(0,1,5,6,7,8,12,13,14,15,19,20,21,22,26,27,28,29,33,34,39:49)

plot(0,0,type = "l", ylim = c(0,200), xlim = c(1,300), main = "Model Training\nGenetic Programming", xlab = "Generations", ylab = "Reward")
g <- evolution(paste("Try_0", ex, "/GP/Log_Fitness/FIT_GP_20_",sep = ""), temp, 300, ".txt",2)
polygon(c(1:300,rev(1:300)), c(g$desvpos, rev(g$desvneg)), col = "grey")
lines(1:300, g$custos, ylim = c(0,300), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:300, g$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:300, g$desvmin, col = "darkgreen", pch = 2, lty = 6)
g <- sel_best(paste("Try_0", ex, "/GP/Log_Fitness/FIT_GP_20_",sep = ""), temp, 300, ".txt",2)
lines(1:length(g$V2), g$V2, col = "orange", pch = 2, lwd = 2)

# Plot Q-Learning Model Tranining reward
plot(0,0,type = "l", ylim = c(0,200), xlim = c(1,400), main = "Model Training\nQ-Learning", xlab = "Episodes", ylab = "Reward")
q <- evolution(paste("Try_0", ex, "/QL/Scores/SCR_QL__",sep = ""), 0:49, 400, ".csv", 2)
polygon(c(1:400,rev(1:400)), c(q$desvpos, rev(q$desvneg)), col = "grey")
lines(1:400, q$custos, ylim = c(0,200), xlim = c(1,400), type = "l", col = "red", lwd = 3)
box()
lines(1:400, q$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:400, q$desvmin, col = "darkgreen", pch = 2, lty = 6)
q <- sel_best(paste("Try_0", ex, "/QL/Scores/SCR_QL__",sep = ""), 0:49, 400, ".csv", 2)
lines(1:length(q$V2), q$V2, col = "orange", pch = 2, lwd = 2)

plot.new()
legend("center", legend=c("Highest value","Average value", "Lowest value", "Best Model", "Standard Deviation"),col=c("blue", "red", "darkgreen",  "orange", "black"), lty = c(6,1,6,1,1), lwd = c(2,3,2,3,2), cex =1.5)
dev.off()
remove(g,q,d)
#####################################
#####################################
#####################################
dev.off()
png(filename = paste("Try_0", ex ,"/Model_Time_TRY",ex,".png", sep = ''), height = 520, width = 750)
par(mfrow = c(2,2))

# Plot Deep Learning Model Tranining time
plot(0,0,type = "l", ylim = c(2,5), xlim = c(1,25), main = "Model Time Training\nDeep Learning", xlab = "Epochs", ylab = "Time (s)")
d <- evolution(paste("Try_0", ex, "/DL/Scores/SCR_DL_8_",sep = ""), 0:49, 25, ".csv",3)
polygon(c(1:25,rev(1:25)), c(d$desvpos, rev(d$desvneg)), col = "grey")
lines(1:25, d$custos, ylim = c(2,5), xlim = c(1,25), type = "l", col = "red", lwd = 3)
box()
lines(1:25, d$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:25, d$desvmin, col = "darkgreen", pch = 2, lty = 6)
d <- sel_best(paste("Try_0", ex, "/DL/Scores/SCR_DL_8_",sep = ""), 0:49, 25, ".csv",2)
lines(1:length(d$V3), d$V3, col = "orange", pch = 2, lwd = 2)

# Plot Genetic Programming Model Training Time
plot(0,0,type = "l", ylim = c(40,180), xlim = c(1,300), main = "Model Time Training\nGenetic Programming", xlab = "Generations", ylab = "Time (s)")
g <- evolution(paste("Try_0", ex, "/GP/Log_Fitness/FIT_GP_20_",sep = ""), temp, 300, ".txt",3)
polygon(c(1:300,rev(1:300)), c(g$desvpos, rev(g$desvneg)), col = "grey")
lines(1:300, g$custos, ylim = c(40,180), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:300, g$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:300, g$desvmin, col = "darkgreen", pch = 2, lty = 6)
g <- sel_best(paste("Try_0", ex, "/GP/Log_Fitness/FIT_GP_20_",sep = ""), temp, 300, ".txt",3)
lines(1:length(g$V3), g$V3, col = "orange", pch = 2, lwd = 2)

# Plot Q-Learning Model Tranining time
plot(0,0,type = "l", ylim = c(0,15), xlim = c(1,400), main = "Model Time Training\nQ-Learning", xlab = "Episodes", ylab = "Time (ms)")
q <- evolution(paste("Try_0", ex, "/QL/Scores/SCR_QL__", sep = ""), 0:49, 400, ".csv", 3)
polygon(c(1:400,rev(1:400)), c(q$desvpos, rev(q$desvneg))*1000, col = "grey")
lines(1:400, q$custos*1000, ylim = c(0,200), xlim = c(1,400), type = "l", col = "red", lwd = 3)
box()
lines(1:400, q$desvmax*1000, col = "blue", pch = 2, lty = 6)
lines(1:400, q$desvmin*1000, col = "darkgreen", pch = 2, lty = 6)
q <- sel_best(paste("Try_0", ex, "/QL/Scores/SCR_QL__",sep = ""), 0:49, 200, ".csv", 3)
lines(1:length(q$V3), q$V3, col = "orange", pch = 2, lwd = 2)


plot.new()
legend("center", legend=c("Slowest","Average", "Highest", "Best Model", "Standard Deviation"),col=c("blue", "red", "darkgreen",  "orange", "black"), lty = c(6,1,6,1,1), lwd = c(2,3,2,3,2), cex =1.5)
dev.off()
remove(g,q,d)
#####################################
#####################################
#####################################
dev.off()
png(filename = paste("Try_0", ex ,"/Model_Osc_TRY",ex,".png", sep = ''), height = 520, width = 750)
par(mfrow = c(2,2))

# DL Balancing
plot(0,0,type = "l", ylim = c(-.2,.2),xlim = c(1,200), main = "Model Angular Oscillation Range\nDeep Learning", xlab = "Steps", ylab = "theta")
d<-balancing_plot(paste("Try_0", ex, "/DL/DL_GAMES/Game_DL_8_", sep = ""),0:49,200,".csv",4)
#polygon(c(1:200,rev(1:200)), c(d$desvpos, rev(d$desvneg)), col = "grey")
polygon(c(rev(1:200),1:200), c(rev(d$desvpos), d$desvneg), col = "grey")
lines(1:200, d$custos, ylim = c(0,300), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:200, d$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:200, d$desvmin, col = "darkgreen", pch = 2, lty = 6)
d <- sel_best_game(paste("Try_0", ex, "/DL/Scores/SCR_DL_8_", sep = ""), 0:49, 200, ".csv", 3,paste("Try_0", ex, "/DL/DL_GAMES/Game_DL_8_",sep = ""))
lines(1:length(d$V4), d$V4, col = "orange", pch = 2, lwd = 2)

# GP Balancing
#temp<-c(1,3,5,6,7,8,10,12,13,14,15,17,19,20,21,22,24,26,27,28,29,33,34,35,36,38,39,40,41,42,44,45,46,47)
plot(0,0,type = "l", ylim = c(-.2,.2),xlim = c(1,200), main = "Model Angular Oscillation Range\nGenetic Programming", xlab = "Steps", ylab = "theta")
g<-balancing_plot(paste("Try_0", ex, "/GP/GP_GAMES/Game_GP_20_",sep = ""),temp,200,".csv",4)
polygon(c(1:200,rev(1:200)), c(g$desvpos, rev(g$desvneg)), col = "grey")
lines(1:200, g$custos, ylim = c(0,300), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:200, g$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:200, g$desvmin, col = "darkgreen", pch = 2, lty = 6)
g <- sel_best_game(paste("Try_0", ex, "/GP/Log_Fitness/FIT_GP_20_",sep = ""), temp, 200, ".txt", 3,paste("Try_0", ex, "/GP/GP_GAMES/Game_GP_20_",sep = ""))
lines(1:length(g$V4), g$V4, col = "orange", pch = 2, lwd = 2)


# QL Balancing
plot(0,0,type = "l", ylim = c(-.2,.2),xlim = c(1,200), main = "Model Angular Oscillation Range\nQ-Learning", xlab = "Steps", ylab = "theta")
q<-balancing_plot(paste("Try_0", ex, "/QL/QL_GAMES/Game_QL__",sep = ""),temp,200,".csv",4)
polygon(c(rev(1:200),1:200), c(rev(q$desvpos), q$desvneg), col = "grey")
lines(1:200, q$custos, ylim = c(0,300), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:200, q$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:200, q$desvmin, col = "darkgreen", pch = 2, lty = 6)
q <- sel_best_game(paste("Try_0", ex, "/QL/Scores/SCR_QL__",sep = ""), 0:49, 200, ".csv", 3,paste("Try_0", ex, "/QL/QL_GAMES/Game_QL__",sep = ""))
lines(1:length(q$V4), q$V4, col = "orange", pch = 2, lwd = 2)

plot.new()
legend("center", legend=c("Maximum Amplitude","Average Amplitude", "Minimum Amplitude", "Best Model", "Standard Deviation"),col=c("blue", "red", "darkgreen",  "orange", "black"), lty = c(6,1,6,1,1), lwd = c(2,3,2,3,2), cex =1.5)
dev.off()
remove(g,q,d)
#####################################
#####################################
#####################################
dev.off()
png(filename = paste("Try_0", ex ,"/Model_Pos_TRY",ex,".png", sep = ''), height = 520, width = 750)
par(mfrow = c(2,2))

# DL Balancing
plot(0,0,type = "l", ylim = c(-1,1),xlim = c(1,200), main = "Model Position Oscillation Range\nDeep Learning", xlab = "Steps", ylab = "x")
d<-balancing_plot(paste("Try_0", ex, "/DL/DL_GAMES/Game_DL_8_",sep = ""),temp,200,".csv",2)
#polygon(c(1:200,rev(1:200)), c(d$desvpos, rev(d$desvneg)), col = "grey")
polygon(c(rev(1:200),1:200), c(rev(d$desvpos), d$desvneg), col = "grey")
lines(1:200, d$custos, ylim = c(0,300), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:200, d$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:200, d$desvmin, col = "darkgreen", pch = 2, lty = 6)
d <- sel_best_game(paste("Try_0", ex, "/DL/Scores/SCR_DL_8_",sep = ""), 0:49, 200, ".csv", 3,paste("Try_0", ex, "/DL/DL_GAMES/Game_DL_8_",sep = ""))
lines(1:length(d$V2), d$V2, col = "orange", pch = 2, lwd = 2)

# GP Balancing
#temp<-c(1,3,5,6,7,8,10,12,13,14,15,17,19,20,21,22,24,26,27,28,29,33,34,35,36,38,39,40,41,42,44,45,46,47)
plot(0,0,type = "l", ylim = c(-1,1),xlim = c(1,200), main = "Model Position Oscillation Range\nGenetic Programming", xlab = "Steps", ylab = "x")
g<-balancing_plot(paste("Try_0", ex, "/GP/GP_GAMES/Game_GP_20_",sep = ""),temp,200,".csv",2)
polygon(c(rev(1:200),1:200), c(rev(g$desvpos), g$desvneg), col = "grey")
lines(1:200, g$custos, ylim = c(0,300), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:200, g$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:200, g$desvmin, col = "darkgreen", pch = 2, lty = 6)
g <- sel_best_game(paste("Try_0", ex, "/GP/Log_Fitness/FIT_GP_20_",sep = ""), temp, 200, ".txt", 3,paste("Try_0", ex, "/GP/GP_GAMES/Game_GP_20_",sep = ""))
lines(1:length(g$V2), g$V2, col = "orange", pch = 2, lwd = 2)

# QL Balancing
plot(0,0,type = "l", ylim = c(-1,1), xlim = c(1,200), main = "Model Position Oscillation Range\nQ-Learning", xlab = "Steps", ylab = "x")
q<-balancing_plot(paste("Try_0", ex, "/QL/QL_GAMES/Game_QL__",sep = ""),temp,200,".csv",2)
polygon(c(rev(1:200),1:200), c(rev(q$desvpos), q$desvneg), col = "grey")
lines(1:200, q$custos, ylim = c(0,300), xlim = c(1,300), type = "l", col = "red", lwd = 3)
box()
lines(1:200, q$desvmax, col = "blue", pch = 2, lty = 6)
lines(1:200, q$desvmin, col = "darkgreen", pch = 2, lty = 6)
q <- sel_best_game(paste("Try_0", ex, "/QL/Scores/SCR_QL__",sep = ""), 0:49, 200, ".csv", 3,paste("Try_0", ex, "/QL/QL_GAMES/Game_QL__",sep = ""))
lines(1:length(q$V2), q$V2, col = "orange", pch = 2, lwd = 2)

plot.new()
legend("center", legend=c("Maximum Amplitude","Average Amplitude", "Minimum Amplitude","Best Model", "Standard Deviation"),col=c("blue", "red", "darkgreen",  "orange", "black"), lty = c(6,1,6,1,1), lwd = c(2,3,2,3,2), cex =1.5)
dev.off()
remove(g,q,d)

