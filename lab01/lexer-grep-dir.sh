#!/bin/sh

DIR="test"

REGEXP="#(include)\b.*"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
