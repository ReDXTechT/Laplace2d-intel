#!/bin/bash


cd "$(dirname "$0")"

# Execute make clean


# Execute make all
source ./make.sh


# Name of the executable
EXE=./exe
{ time $EXE > output.txt; } 2> time.txt

# Redirect output of the executable to a file
$EXE > output.txt

# Expected values, adjust as necessary
declare -A expected_values=(
    ["0"]=0.250000
    ["100"]=0.002397
    ["200"]=0.001204
    ["300"]=0.000804
    ["400"]=0.000603
    ["500"]=0.000483
    ["600"]=0.000403
    ["700"]=0.000345
    ["800"]=0.000302
    ["900"]=0.000269
)

# Tolerance
tolerance=0.000001

# Flags to mark if output is as expected and execution time is within range
is_output_expected=true
is_exec_time_within_range=true

# Iterate through each line of the output
while read -r line; do


    # Get the iteration and value
    iteration=$(echo "$line" | awk '{print $1}' | tr -d ',')
    value=$(echo "$line" | awk '{print $2}')

    # echo "Read iteration: $iteration, value: $value"

    # Compare with expected value, if an expected value is defined
    if [ "${expected_values[$iteration]}" != "" ]; then
        #echo "Expected value for iteration $iteration is defined"
        difference=$(echo "${expected_values[$iteration]} - $value" | bc -l | tr -d -)

        #echo "Difference at iteration $iteration is $difference"

        if (( $(echo "$difference > $tolerance" | bc -l) )); then
            is_output_expected=false
            echo "Value at iteration $iteration is $value, but expected ${expected_values[$iteration]}."
        fi
    fi
done < output.txt
echo "Execution time:"
cat time.txt
if $is_output_expected; then
    echo "accepted"
else
    echo "rejeted"
fi
