#!/bin/bash

while getopts d:o: option
do
    case "${option}"
        in
        d)sitedirectory=${OPTARG};;
        o)owner=${OPTARG};;
    esac
done

mkdir "$sitedirectory"

echo "Sitename : $sitedirectory"
echo "Owner : $owner"