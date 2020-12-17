#!/bin/bash
let value=10
let i=0

while [[ $value -ne 1010 ]]; do
    while [[ $i -lt 10 ]]; do
        (sudo perf stat -e cache-references,cache-misses ./cache_not_friendly $value > /dev/null) > out 2>&1 && cat out | grep "%" >> miss$value
        i=$(($i + 1))
    done
    
    value=$(($value + 10))
    i=0
done