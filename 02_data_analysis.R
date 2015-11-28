library(ggplot2)
library(viridis)

lotr_main <- read.delim("lotr_main_characters.tsv")

lotr_main <- lotr_main %>% group_by(Character) %>% 
	mutate(sum = sum(wordcount)) %>%
	ungroup() %>% 
	arrange(Character,sum) %>% 
	mutate(Character = reorder(Character,sum))

p <- lotr_main %>% ggplot(aes(x = Character, y = wordcount, fill = Film)) + 
	geom_bar(stat="identity",position = "dodge") +
	coord_flip() +
	scale_fill_viridis("Film",discrete = TRUE, option = "D") +
	theme(panel.background = element_blank())
	
	
ggsave("plot_main_character.png", p)
