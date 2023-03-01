#!/bin/bash

dbname=$1
numregex="^[0-9]*$"
counter=1

cd ./"$dbname"


read -p "Enret Table Name: " tablename
regex="^[A-Za-z][A-Za-z0-9]*$"
if [ -f "$tablename" ]
then
        echo "INVALID Creation There is Table With The Same Name"
elif [ "$tablename" == "" ]
then
        echo "Table Name Can Not Be Empty"
elif [[ "$tablename" =~ $regex ]]
then
	touch $tablename
#num is int?
read -p "numbers of columns= " num
while [[ ! $num =~ $numregex ]]
do
        echo "enter valid number"
        read -p "numbers of columns= " num
done

#datatype is int or string 
while [ $counter -le $num ]
do

        if [ $counter == 1 ]
        then
                read -p "Enter PK column datatype {string/int}: " coltype;
                while [[ "$coltype" != *(int)*(string) || -z "$coltype" ]]; do
                        echo "Invalid datatype";
                        read -p "Enter column datatype {string/int}: " coltype;
                done
        else
                read -p "Enter $counter column datatype {string/int}: " coltype;
                while [[ "$coltype" != *(int)*(string) || -z "$coltype" ]]; do
                        echo "Invalid datatype";
                        read -p "Enter column datatype {string/int}: " coltype;
                done

        fi

        if [[ $counter -eq $num ]];
then
        echo  $coltype >> $tablename;

else
        echo -n $coltype"," >> $tablename;
fi

((counter++))
done
counter=1
while [ $counter -le $num ]
do

        if [ $counter == 1 ]
        then
                read -p "Enter PK column name: " colname;
        else
		read -p "Column $counter Name: " colname;

        fi

	if [[ $counter -eq $num ]];
then
        echo  $colname >> $tablename;

else
        echo -n $colname"," >> $tablename;
fi

((counter++))

done

echo "$tablename has been created Successfully!"

else
        echo "Table Name Can Not Contain Spaces OR Start with Number"
fi


