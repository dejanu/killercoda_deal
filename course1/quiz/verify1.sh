#!/bin/bash

# Run the command and count the number of lines
count=$(grep -iE "cowsay|Hello World!" /tmp/two | wc -l)

# Check if the count is not equal to 2
if [ $count -ne 2 ]; then
    exit 1
fi
