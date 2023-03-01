#!/bin/bash
DB_name=$1
#echo $DB_name
cd $DB_name
read -p "Enter table name " table
if [ ! -f $table ]
then
	echo "File not found"
else 
	rm $table
	echo "table deleted successfuly "
cd .. 
./currentDB.sh $DB_name
fi

