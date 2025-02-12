#!/bin/sh

DIR="folly"

REGEXP="\b[0-9]*\.[0-9]+([eE][-+]?[0-9]+)?\b"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
