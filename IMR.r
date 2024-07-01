setwd('/home/maple/Desktop/DAI_Argument/')

library(ggplot2)
library(dplyr)
library(tidyr)

df <- read.csv("imr.csv")

df %>% select(-"year", -'Team') %>% summary()

df_melted <- df %>% pivot_longer(cols = c('Dental', 'Flu', 'PHA', 'MHA'), names_to='IMR_Item', values_to = 'Days_Late')

df_melted %>% ggplot(aes(x=Days_Late, color=IMR_Item, fill=IMR_Item)) + geom_histogram(position='identity', alpha =0.3) + coord_flip() + facet_wrap(~IMR_Item) + ggtitle('Comparison of Simulated Overdue IMR') + ylab('Count') + xlab('Days Late')
df_melted$Team <- as.factor(df_melted$Team)
df_melted %>% filter(IMR_Item == 'Dental') %>% ggplot(aes(x=Days_Late, color=Team, fill=Team)) + geom_boxplot(alpha =0.3) + coord_flip() + ggtitle('Comparison of Overdue Dental By Team') + ylab('') + xlab('Days Late')
df_melted %>% filter(IMR_Item == 'Dental') %>% ggplot(aes(x=Days_Late, color=Team, fill=Team)) + geom_histogram(position='identity', alpha =0.3) + coord_flip() + facet_wrap(~Team) + ggtitle('Comparison of Overdue Dental By Team') + ylab('') + xlab('Days Late')