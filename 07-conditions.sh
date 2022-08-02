#!/bin/bash

# case and if conditional commands, if command is widely because it has more options than case command

# IF Condition
# if found in three forms

# simple IF
# IF [ expression ]
# then
# commands
# fi

if [ 1 -eq 1 ]
then
  echo HELLO
fi

# Expressions are important
# 1. String Tests
# Operators : ==, != , -z
# 2. Number Tests
# 3. File Test

a="abc"
if [ $a == "abc" ]; then
  echo Both are equal
fi

if [ $a != "abc" ]; then
  echo "Both are not equal"
fi

if [ -z "$b" ]; then
  echo b variable is empty
fi