#!/bin/bash -x

# Create a report for the month of June
# Author: kschaefer

if [[ ! $1 ]]; then
    echo "Error: missing parameter: month name"
    exit 1
fi
month="$1"

if [[ ! $2 ]]; then
    dir="$2"
else
    dir"$HOME/reports"
fi

input_file="sample1.csv"
if [[ ! input_file ]]; then
    echo "Error: input file not found."
    exit 1
fi

mkdir -p "$dir"

if grep "$month" "$input_file" > "$dir/${month}_report.csv"
then
    echo "Report created. $dir/${month}_report.csv"
else
    echo "Month $month not found. $dir/${month}_report.csv"
fi
