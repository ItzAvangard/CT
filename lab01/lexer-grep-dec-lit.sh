#!/bin/sh

DIR="test"

DEC="(0|[1-9][0-9']*('?[0-9]+)*)"

SUFF="(u|U|l|L|ll|LL|z|Z)?"

REGEXP="\\b(${DEC})${SUFF}\\b"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
