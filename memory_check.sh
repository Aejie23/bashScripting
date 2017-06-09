#!bin/bash

total_Mem= $(free |grep Mem: |awk '{ print $2 }'| grep % | grep -v Use | sort -n |cut -d '%' -f1)

while getopts :c:w:z: $total_Mem; do
	case $total_Mem in
		
		c) ["$total_Mem" -ge "90"]  
		exit
		;;		
		
		w) [ \("$total_Mem" -ge "60" ) && \ ("$total_Mem" -lt "60")]
		exit
		;;
				
		z) ["$total_Mem" -lt "90"]
		exit
		;;
		
		?) echo "Please enter required parameter, from 0-100"

	esac

done
