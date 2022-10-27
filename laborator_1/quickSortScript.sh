#!/bin/bash

start=`date +%s`
swift quickSort.swift 5000
end=`date +%s`
runtime=$((end-start))

echo "Diferenta pentru un set de date (random) de 5000 elemente:" $runtime

start=`date +%s`
swift quickSort.swift 15000
end=`date +%s`
runtime=$((end-start))

echo "Diferenta pentru un set de date (random) de 15000 elemente:" $runtime

start=`date +%s`
swift quickSort.swift 30000
end=`date +%s`
runtime=$((end-start))

echo "Diferenta pentru un set de date (random) de 30000 elemente:" $runtime

