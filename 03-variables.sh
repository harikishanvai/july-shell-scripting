#!/bin/bash

a=100
b=devops

echo $a
echo $b
echo ${a}times

DATE=2022-07-2022
echo Today date is $DATE

DATE=$(date +%F)
echo Today date is $DATE

x=10
y=30
ADD=$(($x+$y))
echo Add = $ADD
