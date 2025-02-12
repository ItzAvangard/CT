#!/bin/sh

DIR="folly"

REGEXP="\b[0-9]+[A-F]+\b"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
