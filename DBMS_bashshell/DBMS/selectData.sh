#!/bin/bash
dbname=$1
cd $dbname

read -p "Enter table Name: " tbname
if [ ! -f $tbname ]
then
	echo "Table Not Found"
else
awk 'NR>=2' $tbname > temp.txt
select choice in "Select all columns" "select specific column" "select columns where condition"
do
	case $choice in
		 "Select all columns")
			 	
				column -t -s ',' -o ' | ' temp.txt 2> /dev/null
				rm temp.txt
			cd ..
			./currentDB.sh $dbname
			;;

		"select specific column")
				#read -p "Enter Number of columns: " number;
				let flag=0
				#for (( i = 1; i <= number; i++ )); do
					read -p "Enter column Name: " colname;
					IFS=","
					read -a colNames <<<"$(head -1 temp.txt )"
					for item in "${colNames[@]}"; do
					 	if [[ $colname == "$item" ]]
					 	then
						awk -F ',' '{if(NR==1){
						for(i=1 ;i <= NF; i++)
						{
							if($i=="'$colname'")
							{
								var=i
								break;
						    	}	
							}}{print "\t | \t" $var "\t | \t"}}' temp.txt
							((flag=1))
							
						fi
					done
					if [[ $flag == 0 ]]
					then
						echo "This Column is not included in this Table"
						rm temp.txt
						cd ..
						./currentDB.sh $dbname
						break;
					fi
					
			#done
			rm temp.txt
			cd ..
                        ./currentDB.sh $dbname
			;;

		"select columns where condition")
			read -p "Enter column name : " colName
			read -p "Enter column value : " colValue
			IFS=","
			read -a colNames <<<"$(head -1 temp.txt )"
			col_num=${#colNames[@]}
			for(( i = 0 ; i < $col_num ; i++ ))
			do
        			if [ "$colName" == "${colNames[i]}" ]
        			then
                			index=$i
                		break
        			fi
         		done
         		
         		if [ "$index" == "" ]
         		then 
         			echo "This Column is not included in this Table"
				rm temp.txt
				cd ..
				./currentDB.sh $dbname
				
         		exit
         		fi
			typeset -i search
			search="$index+1"
			flag2=$(awk ' BEGIN{FS=","} {if ($'$search' == "'$colValue'" ) { print $0 }}' $tbname)
			if [[ $flag2 == "" ]]
			then
				echo "This Value is not included in this Table"
				rm temp.txt
				cd ..
				./currentDB.sh $dbname
				break;
				else
				awk ' BEGIN{FS=","} {if (NR==1) { print "\t | \t" $0 "\t | \t"}}' temp.txt
				awk ' BEGIN{FS=","} {if ($'$search' == "'$colValue'" ) { print "\t | \t" $0 "\t | \t"}}' $tbname
			fi
			rm temp.txt
			cd ..
                        ./currentDB.sh $dbname
			;;

	esac	
done
fi
