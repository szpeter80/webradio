#!/bin/bash
cat $1 | nc -N localhost 9294
