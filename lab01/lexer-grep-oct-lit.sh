#!/bin/sh

DIR="test"

OCT="0[0-7']+('?[0-7]+)*"

SUFF="(u|U|l|L|ll|LL|z|Z)?"

REGEXP="\\b(${OCT})${SUFF}\\b"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
