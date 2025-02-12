#!/bin/sh

DIR="folly"

REGEXP="\b(include|define|if|else|elif|error)\b"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
