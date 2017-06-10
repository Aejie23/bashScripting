#! /bin/bash

#a script to check memory usage

#prints total free memory usages
total_Mem= $(free |grep Mem: |awk '{ print $2 }'| grep % | grep -v Use | sort -n |cut -d '%' -f1)
top_mem= $(top |grep Mem: | awk '{print $3}' | grep % | grep -v Use | sort -n | cut -d "%" -f1)
TIME=$(date +%k%M)
DAY=`/bin/date +%Y%m%d`

#sssss
while getopts :c:w:z $total_Mem; do
	case $total_Mem in
		
		c) [\("$total_Mem" -ge "90"] && \ ("$total_Mem" -lt "90")] 
		exit 1
		;;		
		
		w) [\("$total_Mem" -ge "60" ) && \ ("$total_Mem" -lt "60")]
		exit 1
		;;
				
		z) [\("$total_Mem" -ge "90"]
		
		echo $top_mem | mail -s " '$DAY' '$TIME' memory check - critical" $z
		
		;;
		
		?) echo "Please enter required parameter, from 0-100"

	esac
	
done
