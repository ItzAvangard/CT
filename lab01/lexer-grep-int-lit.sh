#!/bin/sh

DIR="test"

DEC="(0|[1-9][0-9']*('?[0-9]+)*)"

OCT="0[0-7']+('?[0-7]+)*"

HEX="0[xX][0-9a-fA-F']+('?[0-9a-fA-F]+)*"

SUFF="(u|U|l|L|ll|LL|z|Z)?"

REGEXP="\\b(${DEC}|${OCT}|${HEX})${SUFF}\\b"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
