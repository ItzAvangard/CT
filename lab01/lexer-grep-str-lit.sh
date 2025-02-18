#!/bin/sh

DIR="test"

STR="(L|u8|u|U)?\"([^\\\"]|\\.)*\""

REGEXP="$STR"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
