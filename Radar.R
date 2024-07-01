setwd('/home/maple/Desktop/DAI_Argument/')

library(ggplot2)
library(dplyr)
library(fmsb)


df <- read.csv('radar.csv')
team <- df[1:6,]
member <- df[5,] %>% select(-'Names')
candidates <- df[-c(1:6),]

colors_border=c( rgb(0.2,0.5,0.5,0.6), rgb(0.8,0.2,0.5,0.6) , rgb(0.7,0.5,0.1,0.6), rgb(0.6,0.2,0.5,0.6) , rgb(0.3,0.6,0.3,0.6) )
colors_in=c( rgb(0.2,0.5,0.5,0.2), rgb(0.8,0.2,0.5,0.2) , rgb(0.7,0.5,0.1,0.2),  rgb(0.6,0.2,0.5,0.2) , rgb(0.3,0.6,0.3,0.2) )

team_total <- team %>% select(-'Names') %>% colSums()
team_loss <- team_total - member
temp <- rbind(team_total %>% max(), rep(0,5), team_total, team_loss)
temp <- as.data.frame(temp)
radarchart(temp,
           #custom polygon
           pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
           #custom the grid
           cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
           #custom labels
           vlcex=0.8 
           )
legend(x=0.7, y=1, legend = c("Team Strength", 'Team After Loss'), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)


candidates_filtered <- candidates %>% select(-'Names')
temp <- rbind(candidates_filtered %>% max(), rep(0,5), candidates_filtered)
temp <- as.data.frame(temp)
radarchart(temp,
           #custom polygon
           pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
           #custom the grid
           cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
           #custom labels
           vlcex=0.8 
)
legend(x=0.7, y=1, legend = candidates$Names, bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)


member <- candidates[2,] %>% select(-'Names')
new_team_total <- team_loss + member
temp <- rbind(rbind(team_total, new_team_total) %>% max(), rep(0,5), team_total, team_loss, new_team_total)
temp <- as.data.frame(temp)
radarchart(temp,
           #custom polygon
           pcol=colors_border , pfcol=colors_in , plwd=4 , plty=1,
           #custom the grid
           cglcol="grey", cglty=1, axislabcol="grey", caxislabels=seq(0,20,5), cglwd=0.8,
           #custom labels
           vlcex=0.8 
)
legend(x=0.7, y=1, legend = c("Original Team", "Team After Loss", 'Team After Gain'), bty = "n", pch=20 , col=colors_in , text.col = "grey", cex=1.2, pt.cex=3)

