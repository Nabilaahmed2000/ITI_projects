#!/bin/bash
read -p "Enter DataBase Name : "
regex="^[A-Za-z][A-Za-z]*$"
cd ./DBMS/
if [ -d "$REPLY" ]
then
        echo "INVALID Creation There is Database With The Same Name"
elif [ "$REPLY" == "" ]
then
        echo "DataBase Name Can Not Be Empty"
elif [[ "$REPLY" =~ $regex ]]
then
        mkdir "$REPLY"

else
        echo "DataBase Name Can Not Contain Spaces OR Numbers"
fi
cd ..
./project.sh
