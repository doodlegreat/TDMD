#ATF3_sequence<-"MMLQHPGQVSASEVSASAIVPCLSPPGSLVFEDFANLTPFVKEELRFAIQNKHLCHRMSSALESVTVSDRPLGVSITKAEVAPEEDERKKRRRERNKIAAAKCRNKKKEKTECLQKESEKLESVNAELKAQIEELKNEKQHLIYMLNLHRPTCIVRAQNGRTPEDERNLFIQQIKEGTLQS"
library(rvest)
library(stringr)
#get ATF3 amino acid sequence from uniprot database
#library(rvest)
url <- 'http://www.uniprot.org/uniprot/P18847#sequences' 
page <- html_session(url) 
info <- html_nodes(page, 'pre.sequence')
content <- html_text(info)
#library(stringr)
cells <- sapply(content, str_split, '\\s', USE.NAMES = FALSE)
aa_seq<-cells[[1]]
ATF3_sequence<-paste(aa_seq,collapse = "")
ATF3_sequence<-str_replace_all(string=ATF3_sequence,pattern="[0-9]",replacement="")
#str_match_all(aa, "[A-Z]") #or extract the AA symbol
#library(stringr)
location<-str_locate_all(ATF3_sequence,"[GAVLIPFMT][A-Z][A-Z][GAVLIPFMT][GAVLIPFMT]")
location_frame<-as.data.frame(location)
start_site<-location_frame$start
end_site<-location_frame$end
cutoff_point<-c(0,40,85,114,147,181)
region_name<-c("A_N","R","B","Z","A_C")
motif_distribution<-table(cut(start_site,breaks=cutoff_point))
break_name<-paste(region_name,"\n",names(motif_distribution))
barplot(motif_distribution,col = "green",main = "ATF3 LXXLL Distribution",xlab = "Amino Acid Region",ylab = "Motif Start Site Frequency", names.arg = break_name)

