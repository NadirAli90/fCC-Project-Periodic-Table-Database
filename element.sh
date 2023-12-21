#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"

NOT_FOUND () {
    echo "$1"
}

if [[ -z $1 ]]; then
  echo "Please provide an element as an argument."
else
    if [[ $1 =~ ^[0-9]+$ ]]; then
        DATA_QUERY=$($PSQL "SELECT p.atomic_number,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius,t.type,e.symbol,e.name FROM properties AS p FULL JOIN elements AS e USING (atomic_number) FULL JOIN types AS t USING(type_id) WHERE p.atomic_number = $1;")
        IFS=" | " read -r ATOMIC_ID MASS MP BP TYPE SYMBOL NAME <<< $DATA_QUERY
        if [[ $ATOMIC_ID ]]; then
         echo "The element with atomic number $ATOMIC_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius." 
        else
         NOT_FOUND "I could not find that element in the database."
        fi
    elif [[ $1 =~ ^[a-zA-Z]{1,2}$ ]]; then
        DATA_QUERY=$($PSQL "SELECT p.atomic_number,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius,t.type,e.symbol,e.name FROM properties AS p FULL JOIN elements AS e USING (atomic_number) FULL JOIN types AS t USING(type_id) WHERE e.symbol = '$1';")
        IFS=" | " read -r ATOMIC_ID MASS MP BP TYPE SYMBOL NAME <<< $DATA_QUERY
        if [[ $ATOMIC_ID ]]; then
         echo "The element with atomic number $ATOMIC_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius." 
        else
         NOT_FOUND "I could not find that element in the database."
         fi
    elif [[ $1 =~ ^[a-zA-Z]+$ ]]; then
        DATA_QUERY=$($PSQL "SELECT p.atomic_number,p.atomic_mass,p.melting_point_celsius,p.boiling_point_celsius,t.type,e.symbol,e.name FROM properties AS p FULL JOIN elements AS e USING (atomic_number) FULL JOIN types AS t USING(type_id) WHERE e.name = '$1';")
        IFS=" | " read -r ATOMIC_ID MASS MP BP TYPE SYMBOL NAME <<< $DATA_QUERY
        if [[ $ATOMIC_ID ]]; then
         echo "The element with atomic number $ATOMIC_ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MP celsius and a boiling point of $BP celsius." 
        else
         NOT_FOUND "I could not find that element in the database."
        fi
    else 
        NOT_FOUND "I could not find that element in the database."
    fi
fi