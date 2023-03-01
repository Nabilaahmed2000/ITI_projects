#!/bin/bash
dbname=$1
cd $dbname
read -p "Enter table Name: " tbname
if [ ! -f $tbname ]
then
        echo "Table Not Found"
else

int_rejex="^[0-9]+([.][0-9]+)?$"
string_rejex="^[A-Za-z][A-Za-z0-9]*$"
record=""
read -p "Enter Data separated by a comma: " entry
inserted_data=$entry
#echo $entry >>ahmed/testtable
IFS=',' 
read -a strarr <<<"$entry"  
#echo "Name : ${strarr[0]} "  
data_line=$(head -n 1 $tbname)
colum_line=$(ls -l | head -2 | tail -1 $tbname)
primary_key=()
comma=","
read -a data_type <<<"$data_line"
#echo $data_line
#echo $colum_line
col_num="${#data_type[@]}"
#echo $col_num

while read p;
do
        read -a prime<<<"$p"
        #echo ${prime[0]}
        primary_key+=(${prime[0]})
done < $tbname
IFS=""
#echo "$col_num" 
x="${#strarr[@]}" 
#echo $x
if [[ "$col_num" -eq "$x" ]]
then
	for value in "${primary_key[@]}"
	do
    	 if [[ ${strarr[0]} == $value ]] || [[ !  "${strarr[0]}" =~ $int_rejex ]]
    	 then
             echo "invaild key ,try again"
             exit
	 fi
	done
	record+="${strarr[0]},"
	else
	echo "data is bigger than column number"
	exit

fi
for(( i=1 ; i<$col_num ; i++ ))
        do
                if [[ ${data_type[i]} == "string" ]]
                then
                        if [[ ${strarr[i]} =~ $string_rejex ]]
                        then
                                if [ i == $col_num ]
                                then
                                        record+="${strarr[i]}'\n'"

                                else
                                record+="${strarr[i]},"

                                fi
                        else
                                echo "data number ${i} should be string "
				exit
                        fi
                else
                        if [[ ${strarr[i]} =~ $int_rejex ]]
                        then
                                if [ i == $col_num ]
                                then
                                        record+="${strarr[i]}'\n'"

                                else
                                record+="${strarr[i]},"

                                fi
                        else
                                echo "data number ${i} should be intger"
				exit
                        fi
                fi

        done
       # echo $record >> $tbname
       echo $inserted_data >> $tbname
fi
cd ..
./currentDB.sh $dbname
