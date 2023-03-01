#!/bin/bash
dbname=$1
cd $dbname
for file in *;
do
        if [ -f "$file" ]
        then
                echo "$file"
		cd ..
		./currentDB.sh $dbname
        fi
done

