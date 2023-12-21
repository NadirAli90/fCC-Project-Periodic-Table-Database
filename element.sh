#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -c"
if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."  
fi

if [[ $1 =~ ^[0-9]+$ ]]; then
SYMBOL=$($PSQL "")
fi