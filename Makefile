all: plot_main_characters.png

lotr_raw.tsv:
	Rscript 00_download_data.R
	
lotr_main_characters.tsv: lotr_raw.tsv 01_data_cleaning.R
	Rscript 01_data_cleaning.R
	
plot_main_characters.png: lotr_main_characters.tsv 02_data_analysis.R
	Rscript 02_data_analysis.R
	rm Rplots.pdf

clean:
	rm lotr_raw.tsv lotr_main_characters.tsv plot_main_characters.png