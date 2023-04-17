#!/bin/bash

# Check that both parameters are present
if [ $# -lt 2 ]; then
  echo "Usage: $0 x fileinput"
  exit 1
fi

# Extract the parameters
percent=$1
filename=$2

# Check that percent is a number between 1 and 99
if ! [[ "$percent" =~ ^[0-9]+$ ]] || [ "$percent" -lt 1 ] || [ "$percent" -gt 99 ]; then
  echo "Error: percent must be an integer between 1 and 99 (inclusive)"
  exit 1
fi

# Calculate the number of lines to sample
total_lines=$(wc -l < "$filename")
num_lines=$((total_lines * percent / 100))

# Sample the lines
shuf "$filename" | head -n "$num_lines"

