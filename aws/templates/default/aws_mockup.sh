#!/bin/bash

for (( i=1;$i<=$#;i=$i+1 ))
do
    command = "$command ${!i}"
done

echo "Ran aws cli call: [$command]"
exit 0