library(dplyr,quietly = T)

lotr_dat <- read.delim("lotr_raw.tsv")
lotr <- tbl_df(lotr_dat)

film_old_level <- levels(lotr$Film)


film_new_level <- c("The Fellowship Of The Ring", "The Two Towers", "The Return Of The King")
levels(lotr$Film) <- film_new_level

main_characters <- c("Aragorn","Arwen","Frodo","Gandalf","Gimli","Legolas","Sam","Pippin","Merry")


lotr_main <- lotr %>% filter(Character %in% main_characters)


lotr_main <- lotr_main %>% select(c(Film,Character,Race,Words)) %>% 
	group_by(Film, Character,Race) %>% 
	summarise(wordcount = sum(Words)) %>% 
	mutate(Race = plyr::revalue(Race, c(Ainur = "Wizard", Men = "Human"))) %>% 
  droplevels() %>% 
	ungroup() 

write.table(lotr_main, "lotr_main_characters.tsv", quote = FALSE,
						sep = "\t", row.names = FALSE)




