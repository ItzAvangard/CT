#!/bin/sh

DIR="test"

OPT="[0-9']*[\.][0-9']+[lfp]?"
REQ="[0-9']+[\.]"
EXP="[0-9']*[\.][0-9']+[eE][+-]?[0-9']*[lfp]?"
HEX="0[xX][0-9a-fA-F']*\.[0-9a-fA-F']*[pP][0-9a-fA-F']+"

REGEXP="$OPT|$REQ|$EXP|$HEX"

for f in `find $DIR -name "*.cpp"`; do
    echo "*** File $f"
    grep -o -E $REGEXP $f
done
