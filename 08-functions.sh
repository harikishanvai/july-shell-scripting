#!/bib/bash

# variable  : if we assign a name to set of data that is a variable
# function : if we assign a name to set of commands that is a function

# func_name() {
# commands
# commands
# }

## declare a function

Print_Message() {
  echo name
  echo welcome to $1 Training
  echo "Frist Argument in function = $1"
  a=54
  echo "value of a = $a"
  b=64
}

a=5464
Print_Message Devops

echo "Frist Argument in main script = $1"
echo "value of b = $b"

## Note , Function has to declare