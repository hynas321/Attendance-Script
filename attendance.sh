#!/bin/bash

users=$(echo "$(last | head -5 | tr -s " ")" | awk -v N=$1 '{print $1}') 
hours=$(echo "$(last | head -5 | tr -s " ")" | awk -v N=$7 '{print $7}') 
condition=$(echo "$(last | head -5 | tr -s " ")" | awk -v N=$8 '{print $8}') 

alteration=0
declare -i pos=1

for elem in $condition
do

if [ $elem == "still" ]; then
active_user=$(echo $users | cut -d ' ' -f $pos)
active_hour=$(echo $hours | cut -d ' ' -f $pos)
let "pos+=1"

	while read user day hour1 hour2
	do

	if [[ $user == $active_user ]]; then
		current_day=$(date +%a)
		current_time=$(date +%H:%M)
		
 		if [ $day == $current_day ] && 
		[ ! ${current_time//':'} -gt ${hour2//':'} ] && [ ${current_time//':'} -gt ${hour1//':'} ] &&  
	        [ ${hour1//':'} -ge ${active_hour//':'} ] && [ ${hour2//':'} -ge ${active_hour//':'} ]; then
		
		t_output="$user : $current_day : $hour1 : $hour2 : $(tty) : $(date +"%d.%m.%y")"
		echo $t_output >> t_register.txt
		
		let "alteration=1"
		break;
		fi
		
	fi
	done <<< $(awk -F ' : '  '{ print $1, $2, $3, $4; }' students.txt )

fi
done

if [ $alteration == 0 ]; then
	true > t_register.txt
fi

sort t_register.txt | uniq -d >> register.txt
sort t_register.txt | uniq -u | sponge t_register.txt

#Sets the automatic execution of the script (every hour the script runs):
#crontab -e
#* 1 * * * /home/<user>/Desktop/attendance.sh

#Condition for the automatic execution to work:
#chmod +x <cd and name> - changes permission by adding "x" to let crontab execute the script


