#!/bin/bash
db_name=$1
if [ -d "$db_name" ];
then
#echo $db_name
cd $db_name
#ls
read -p "Enter table name  " table_name
#echo $table_name
if  [ ! -f "$table_name" ]
then
        echo "$table_name File not found"
	exit
else
	index=0
read -p "Enter column name : " col_name
#echo $col_name
read -p " Enter column value : " col_val
#echo $col_val
read -p "Enter new value : " new_val
if [ "$col_name" != "" ] && [ "$col_val" != "" ] && [ "$new_val" != "" ]
then
colum_line=$(head -2 $table_name | tail -1 )
IFS=","
read -a col_names <<<"$colum_line"

col_num=${#col_names[@]}
flag=0
for(( i = 0 ; i < $col_num ; i++ ))
do
        if [ "$col_name" = "${col_names[i]}" ]
        then
                index=$i
		flag=1
        fi
done
if [ "$flag" == 0 ]
then 
	echo "column not fount "
	exit
fi
        #echo $index
typeset -i search
search="$index+1"
if [ "$search" == 1 ]
then
	echo "you can't update primary key "
	exit
else
#echo $search
#echo $col_val
res=$(awk ' BEGIN{FS=","} {if ($'$search'== "'$col_val'"  ) print NR  }' $table_name)
#echo $res
if [ $res == "" ]
then
	echo "this value not included in this table "
	exit
fi
sed -i ''$res's/'$col_val'/'$new_val'/g' $table_name
echo "record updated successfuly"
fi
else
	echo " don't Enter null data please "
fi
fi
else
        echo "$db_name directory does not exist."
fi
cd ..
./currentDB.sh $db_name
