#! /bin/bash

#a script to check memory usage

#prints total free memory usages
total_Mem= $(free |grep Mem: |awk '{ print $2 }'| grep % | grep -v Use | sort -n |cut -d '%' -f1)
top_mem= $(top |grep Mem: | awk '{print $3}' | grep % | grep -v Use | sort -n | cut -d "%" -f1)
TIME=$(date +%k%M)
DAY=`/bin/date +%Y%m%d`

#checking of usage memory using getops
while getopts ":c:w:e:" opt "${total_Mem[@]}"; do
	case $opt in
		
		c) [ $total_Mem -ge 90 -a $total_Mem -lt 90 ] 
		
		exit 1
		;;		
		
		w) [ $total_Mem -ge 60 -a $total_Mem -lt 60 ]
		
		exit 1
		;;
				
		e) [ $total_Mem -ge 90 ]
		
		echo $top_mem | mail -s " '$DAY' '$TIME' memory check - critical" $OPTARG
		
		;;
		
		:) echo "Please enter required parameter, from 0-100"
		;;
	esac
done
