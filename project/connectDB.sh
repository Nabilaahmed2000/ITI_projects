#!/bin/bash
read -p "Enter Database Name : " DBname
cd ./DBMS/
for F in *;
do
        if [ -d "$F" ]
        then
                if [ "$F" == "$DBname" ]
                then
			./currentDB.sh "$DBname"
           	 fi
        fi
done
echo "NO DataBase With This Name Exist"

