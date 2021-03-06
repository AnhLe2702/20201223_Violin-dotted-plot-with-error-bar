#Load your dataset (Nature_R dataset)
data <- read.csv(file.choose(), header = T)
#Load package dplyr and ggplot2 loaded 
library(dplyr)
library(ggplot2)
#Compute upper and lower quantile and mean value from Average_length.days
data_melt <- data %>% group_by(Topic) %>% mutate(upper =  quantile(Average_length.days, 0.75), 
                                                 lower = quantile(Average_length.days, 0.25),
                                                 mean = mean(Average_length.days))
#Plot violin dotplot and superimpose error bar, this order ensures errorbars are brought to the front
ggplot(data = data_melt, aes(x=Topic, y=Average_length.days)) +
  geom_violin(col="black") +
  geom_point(position = position_jitter(0.2), color = "cyan3") +
  geom_errorbar(aes(ymin = lower, ymax = upper),col = "red", width =  0.2)
#Assign plot to myplot2
myplot2 <- ggplot(data = data_melt, aes(x=Topic, y=Average_length.days)) +
  geom_violin(col="black") +
  geom_errorbar(aes(ymin = lower, ymax = upper),col = "red", width =  0.2) +
  geom_point(position = position_jitter(0.2), color = "cyan3")
#Final touch, optional to remove background colour
myplot2 + theme(panel.background = element_rect(fill = "white"),
                axis.line.x.bottom = element_line(colour = "black", size = 0.5),
                axis.line.y.left = element_line(colour = "black", size = 0.5),
                axis.title.x = element_text(size=15),
                axis.title.y.left = element_text(size=15),
                axis.text.x = element_text(size=10),
                axis.text.y = element_text(size=10))+
  labs(x="Topics", y="Days")
#Saving plot
setwd("~/Desktop")
ggsave("Nature_R.tiff", width = 8, height = 5)
