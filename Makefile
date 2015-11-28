all: report.html

lotr_raw.tsv:
	Rscript 00_download_data.R
	
lotr_main_characters.tsv lotr_race.tsv population.tsv lotr_heat_map.png lotr_race.png: lotr_raw.tsv 01_data_cleaning.R
	Rscript 01_data_cleaning.R
	
	
barplot_main_characters.png character_plot.png: lotr_main_characters.tsv 02_data_analysis.R
	Rscript 02_data_analysis.R
	rm Rplots.pdf
	
report.html: report.rmd lotr_race.tsv population.tsv lotr_heat_map.png lotr_race.png barplot_main_characters.png character_plot.png 
	Rscript -e 'rmarkdown::render("$<")'

clean:
	rm lotr_raw.tsv lotr_main_characters.tsv lotr_race.tsv population.tsv lotr_heat_map.png lotr_race.png barplot_main_characters.png character_plot.png report.html