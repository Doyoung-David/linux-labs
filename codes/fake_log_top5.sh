#!/bin/bash

#Log file
LOGFILE="fake_access.log"

#URL
URLS=("/" "/index.html" "/login" "/products" "/cart" "/checkout" "/contact")

# 100 lines
for i in {1..100}; do # OR for i in $(shuf 1 100)
	DATE=$(date -d "$((RANDOM%2)) day ago + $((RANDOM%24)) hour" +"%d/%b/%Y:%H:%M:%S")
	IP="10.0.0.$((RANDOM % 255 + 1))"
	URL=$(printf "%s\n" "${URLS[@]}" | shuf -n 1)
	echo "$IP - - [$DATE +0900] \"GET $URL HTTP/1.1\" 200 $((RANDOM%5000+200))" >> "$LOGFILE"
done


# Extract Top 3
awk /10.0.0./ fake_access.log | sort -k1 | cut -d' ' -f1 | uniq -c | sort -k1 -r | head -n 5


