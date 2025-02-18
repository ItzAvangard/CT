#!/bin/sh

DIR="test"

HEX="0[xX][0-9a-fA-F']+('?[0-9a-fA-F]+)*"

SUFF="(u|U|l|L|ll|LL|z|Z)?"

REGEXP="\\b(${HEX})${SUFF}\\b"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
