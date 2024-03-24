#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"



ELEMENT() {
  #if number
  if [[  $1 =~ ^[0-9]+$  ]] 
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $1")
    NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $1")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $1")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $1")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $1")
    TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING (type_id) WHERE atomic_number = $1")

    #Elemento no encontrado
    if [[ -z $NAME ]]; then
      echo "I could not find that element in the database."
      return
    fi
    
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

  #if string, max 2 characters
  elif [[ ${#1} -le 2 ]]
  then
    
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol = '$1'")
    NAME=$($PSQL "SELECT name FROM elements WHERE symbol = '$1'")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER")

    #Elemento no encontrado
    if [[ -z $NAME ]]; then
      echo "I could not find that element in the database."
      return
    fi
    
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

  #if string > 2 characters
  else

    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1'")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name = '$1'")
    NAME=$($PSQL "SELECT name FROM elements WHERE name = '$1'")
    MELTING=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOILING=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING (type_id) WHERE atomic_number = $ATOMIC_NUMBER")

    #Elemento no encontrado
    if [[ -z $NAME ]]; then
      echo "I could not find that element in the database."
      return
    fi
    
    echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."

  fi
}

MAIN_MENU() {
  if [[ -z $1 ]]
  then
    echo "Please provide an element as an argument."
  else
    ELEMENT "$1" 
      fi
}

MAIN_MENU "$1" 
