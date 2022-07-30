#!/bin/bash

read -p 'Enter your Name: ' name
echo "Your Name = $name"

# Special Variables
echo script name = $0
echo first argument = $1
echo all arguments = $*
echo no of arguments = $#

