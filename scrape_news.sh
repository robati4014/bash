



#!/bin/bash

#def var for website.
ynet=https://www.ynetnews.com/category/3082
search="https://www.ynetnews.com/article/[a-zA-Z0-9]\{9\}"
search_1="https://www.ynetnews.com/article/[a-zA-Z0-9]\{9\}[^a-zA-Z0-9]"

# read website
wget -q $ynet -O sub_site_tmp.txt 

#search links with pattern define before

grep -o $search_1 sub_site_tmp.txt | grep -o $search > sub_site.txt

#sort & uniq the links & save 
sort sub_site.txt | uniq > sub_site_uniq.txt

#read the file & count the links
cat sub_site_uniq.txt | wc -l > results.csv

#read every link 
for link in $(cat sub_site_uniq.txt); do

	#read an article from a link & save
	wget -q $link -O currnt_link.txt

	#save the number of names appear
	Netanyahu_cont=$(grep -o Netanyahu currnt_link.txt | wc -l)
	Gantz_cont=$(grep -o Gantz currnt_link.txt | wc -l)

	#print the links to output
	echo -n "$link, " >> results.csv

	#check if the names exist
	if (( Netanyahu_cont == 0 && Gantz_cont == 0 ))
	#if the names not exist print "-"
	then
		echo "-" >> results.csv
	#if one of the names exist print the num of appears
	else
		echo -n "Netanyahu, $Netanyahu_cont, " >> results.csv
		echo "Gantz, $Gantz_cont" >> results.csv
	fi
	
done



#remove sub files



 #find | grep sub | xargs rm
