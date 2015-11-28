all: lotr_main_characters.tsv

lotr_raw.tsv:
	Rscript 00_download_data.R
	
lotr_main_characters.tsv: lotr_raw.tsv
	Rscript 01_data_cleaning.R

clean:
	rm lotr_raw.tsv lotr_main_characters.tsv