#!/bin/bash
select choise in "Create Table" "List Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Return To DataBases"
do
if [ $REPLY -eq 1 ]
then
        ./createTable.sh $1

elif [ $REPLY -eq 2 ]
then
        ./listTable.sh $1

elif [ $REPLY -eq 3 ]
then
        ./dropTable.sh $1

elif [ $REPLY -eq 4 ]
then
        ./insertData.sh $1

elif [ $REPLY -eq 5 ]
then
        ./selectData.sh $1

elif [ $REPLY -eq 6 ]
then
        ./deleteData.sh $1

elif [ $REPLY -eq 7 ]
then
        ./updateTable.sh $1

elif [ $REPLY -eq 8 ]
then
	cd ../
        ./project.sh

else
        echo "Input Not Valid"
fi
done
