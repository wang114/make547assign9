library(ggplot2)
library(dplyr)
library(viridis)

lotr_main <- read.delim("lotr_main_characters.tsv")

character_plot <- ggplot(lotr_main, aes(x = Character , y = Words)) + 
	scale_y_log10() +
	geom_jitter(alpha = 0.7, position = position_jitter(width = 0.1)) +
	stat_summary(fun.y = median, pch = 23, fill = "red",
							 geom = "point", size = 3) + 
	theme_light()

ggsave("character_plot.png",character_plot, dpi = 90)




lotr_main_sub <- lotr_main %>% select(c(Film,Character,Race,Words)) %>% 
	group_by(Film, Character,Race) %>% 
	summarise(wordcount = sum(Words)) %>% 
	droplevels() %>% 
	ungroup() 


lotr_main_sub <- within(lotr_main_sub, Character <-reorder(Character, wordcount, sum))


p <- lotr_main_sub %>% ggplot(aes(x = Character, y = wordcount, fill = Film)) + 
	geom_bar(stat="identity",position = "dodge") +
	coord_flip() +
	scale_fill_viridis("Film",discrete = TRUE, option = "D") +
	theme(panel.background = element_blank()) 

ggsave("barplot_main_characters.png", p, dpi = 90)




