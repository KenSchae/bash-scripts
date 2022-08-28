#!/bin/bash

# Create a report for the month of June
# Author: kschaefer

mkdir -p reports

grep "Jun" sample1.csv > reports/JUN.csv

echo "Report created."