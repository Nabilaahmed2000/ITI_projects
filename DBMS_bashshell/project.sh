#!/bin/bash
select choise in  "Create Database" "List Database" "Connect to Database" "Drop data base" "Exit"
do
if [ $REPLY == 1 ]
then
	./createDB.sh

elif [ $REPLY == 2 ]
then
	./listDB.sh

elif [ $REPLY == 3 ]
then
	./connectDB.sh 
	
elif [ $REPLY == 4  ]
then
	./dropDB.sh
elif [ $REPLY == 5 ]
then
	exit
	fi
done
