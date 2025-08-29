DATE=$(date '+%Y-%m-%d %H:%M')
for i in $(seq 1 $(wc -l < Top5.log)); do
	IP=$(awk -v n="$i"  'NR==n {print $2}' Top5.log)
	if firewall-cmd --list-rich-rules | grep -qw "$IP"; then
		echo "[$DATE] $IP is already blocked" >> blacklist.log
	else
		firewall-cmd --permanent --add-rich-rule="rule family='ipv4' source address='$IP' reject"
		firewall-cmd --reload
		echo "[$DATE] $IP has been successfully blocked" >> blacklist.log
	fi
done
