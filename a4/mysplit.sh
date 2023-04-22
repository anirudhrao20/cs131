#!/bin/bash

# Set the input and output files
input_file="winequality-red.csv"
train_file="train/data.csv"
test_file="test/data.csv"

# Determine the number of entries in the first sub-dataset
total_lines=$(wc -l < "$input_file")
header_line=1
first_dataset_lines=$(echo "($total_lines - $header_line) * 0.8" | bc)
first_dataset_lines=${first_dataset_lines%.*}
second_dataset_lines=$(($total_lines - $header_line - $first_dataset_lines))

# Copy the header line to both sub-datasets
head -n 1 "$input_file" > "$train_file"
head -n 1 "$input_file" > "$test_file"

# Extract the first sub-dataset and clean the data
tail -n +2 "$input_file" | shuf | head -n "$first_dataset_lines" | sed 's/;/,/g' >> "$train_file"

# Extract the second sub-dataset and clean the data
tail -n +2 "$input_file" | shuf | tail -n "$second_dataset_lines" | sed 's/;/,/g' >> "$test_file"

