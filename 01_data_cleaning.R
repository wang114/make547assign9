library(plyr,quietly = T)
library(dplyr,quietly = T)
library(ggplot2)


lotr_dat <- read.delim("lotr_raw.tsv")
lotr <- tbl_df(lotr_dat)
film_old_level <- levels(lotr$Film)
film_new_level <- c("The Fellowship Of The Ring", "The Two Towers", "The Return Of The King")
levels(lotr$Film) <- film_new_level

lotr <- lotr %>% 
	mutate(Race = plyr::revalue(Race, c(Ainur = "Wizard", Men = "Human")))


population <- lotr %>% group_by(Race) %>% 
	summarise(count = length(unique(Character)))

main_characters <- c("Aragorn","Arwen","Frodo","Gandalf","Gimli","Legolas","Sam","Pippin","Merry")
lotr_main <- lotr %>% filter(Character %in% main_characters)



lotr_race <- ddply(lotr, ~ Race, summarize, wordcount = sum(Words)) 
lotr_race <- arrange(lotr_race, desc(wordcount))
race_plot <- lotr_race %>% ggplot(aes(x = reorder(Race,wordcount), y = wordcount)) +
	geom_bar(stat="identity",position = "dodge", fill = "darkgoldenrod1", width = 0.5) +
	theme_bw() + xlab("Race")


lotr_heat_map <- lotr %>% ggplot(aes(Race, Character)) + 
	scale_fill_gradient(low = "yellow",high = "steelblue") + 
	geom_bin2d(binwidth = c(1,1)) +
	theme_light()
	

ggsave("lotr_heat_map.png",lotr_heat_map, scale = 1.5)
ggsave("lotr_race.png",race_plot, dpi = 90)

write.table(lotr_main, "lotr_main_characters.tsv", quote = FALSE,
						sep = "\t", row.names = FALSE)


write.table(lotr_race,"lotr_race.tsv",sep = "\t", 
						row.names = FALSE, quote = FALSE)


write.table(population,"population.tsv",sep = "\t", 
						row.names = FALSE, quote = FALSE)




