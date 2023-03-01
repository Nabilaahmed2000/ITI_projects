#!/bin/bash

cd ./DBMS/
for folder in *;
do
        if [ -d "$folder" ]
        then
                echo "$folder"
        fi
done

cd ..
./project.sh

