#!/bin/bash
db_name=$1
cd $db_name
read -p "Enter table name  " table_name
if [ ! -f $table_tame ]
then
        echo "File not found"
else
read -p "Enter column name : " col_name
#echo $col_name
read -p " Enter column value : " col_val
#echo $col_val
if [ "$col_val" == "" ]
then
	exit
fi
colum_line=$(head -2 $table_name | tail -1 )
IFS=","
read -a col_names <<<"$colum_line"
#echo ${col_names[0]}
#echo ${col_names[1]}
#echo ${col_names[2]}
col_num=${#col_names[@]}

for(( i = 0 ; i < $col_num ; i++ ))
do
	if [ "$col_name" == "${col_names[i]}" ]
        			then
                			index=$i
                		break
        			fi
         		done
         		
         		if [ "$index" == "" ]
         		then 
         			echo "This Column is not included in this Table"
         exit
         fi
        # echo $index
typeset -i search
search="$index+1"
#echo $search
#echo $col_val
res=$(awk ' BEGIN{FS=","} {if ($'$search'== "'$col_val'"  ) print NR  }' $table_name)
#echo $res
if [ "$res" == "" ]
then 
 echo "NO such data in this column "
 exit
 else
sed -i ''$res'd' $table_name
echo "Record deleted succssfuly"
fi
fi

