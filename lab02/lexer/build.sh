#!/bin/sh

flex++ -o CoolLexer.cpp ./CoolLexer.flex

g++ -Wall ./driver.cpp ./CoolLexer.cpp -g -o driver
