#!/bin/bash
read -p "Enter DataBase Name : "
regex="^[A-Za-z][A-Za-z]*$"
cd ./DBMS/
if [ -d "$REPLY" ]
then
        rm -r $REPLY 
	echo "database deleted successfuly"
elif [ "$REPLY" == "" ]
then
        echo "DataBase Name Can Not Be Empty"

else
        echo "DataBase Name Is Not Exist"
fi
cd ..
./project.sh
