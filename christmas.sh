#!/usr/bin/env bash

# ------------------------------------------------------------------
# Script Name:   bashmastree.sh
# Description:   A Bash Script to display a 
#                Christmas tree in Terminal.
# Website:       https://gist.github.com/ostechnix
# Version:       1.0
# Usage:         chmod +x bashmastree.sh
#                ./bashmastree.sh
# ------------------------------------------------------------------

# Clear the screen
clear

# Get terminal size
rows=$(tput lines)
cols=$(tput cols)

# Function to print spaces
print_spaces() {
    for ((space=0; space<$1; space++)); do
        echo -n " "
    done
}

# Function to print leaves with occasional blinking lights
print_leaves() {
    for ((leaf=0; leaf<$1; leaf++)); do
        # Randomly decide to print a leaf or a light
        if (( RANDOM % 20 < 2 )); then  # Adjust the frequency of lights here
            # Randomly choose a color for the blinking light
            case $(( RANDOM % 4 )) in
                0) echo -n -e "\e[5;35mo\e[0m" ;;  # Blinking Pink
                1) echo -n -e "\e[5;34mo\e[0m" ;;  # Blinking Blue
		2) echo -n -e "\e[5;33mo\e[0m" ;;  # Blinking Yellow
		3) echo -n -e "\e[5;37mo\e[0m" ;;  # Blinking White
            esac
        else
            echo -n -e "\e[32m*\e[0m"  # Green color for *
        fi
    done
}

# Function to print the trunk
print_trunk() {
    local trunk_width=${#1}
    local center=$((size - trunk_width / 2))
    print_spaces $center
    echo -e "\e[33m$1\e[0m"  # Brown color for the trunk
}

# Function to print the tree
print_tree() {
    # Size of the tree
    size=10

    # Calculate the starting row and column
    start_row=$(( (rows - size - 10) / 2 ))
    start_col=$(( (cols - 2 * size) / 2 ))

    # Loop to print the tree
    for ((i=1; i<=$size; i++)); do
        tput cup $((start_row + i)) $start_col
        print_spaces $((size-i))
        print_leaves $((2*i-1))
        echo
    done

    # Print the trunk
    trunk="HMH"
    for ((i=0; i<3; i++)); do
        tput cup $((start_row + size + i + 1)) $start_col
        print_trunk $trunk
    done
}

# Function to print the messages
print_messages() {
    local message1="MERRY CHRISTMAS"
    local message2="HAPPY NEW YEAR 2025"
    local start_row1=$((start_row + size + 5))
    local start_row2=$((start_row1 + 1))
    local col1=$(( (cols - ${#message1}) / 2 ))
    local col2=$(( (cols - ${#message2}) / 2 ))

    # Print first message
    for ((i=0; i<=${#message1}; i++)); do
        tput cup $start_row1 $col1
        echo -e "\e[1;36m${message1:0:i}\e[0m"
        sleep 0.2
    done

    # Print second message
    for ((i=0; i<=${#message2}; i++)); do
        tput cup $start_row2 $col2
        echo -e "\e[1;36m${message2:0:i}\e[0m"
        sleep 0.2
	    done
		}

# Print exit instructions
print_exit_instructions() {
    tput cup $((rows - 2)) 0
    echo -e "\e[1;31mPress Ctrl+C to exit\e[0m"
}

# Main loop to keep refreshing the tree and display messages
while true; do
    print_tree
    print_exit_instructions
    print_messages
    sleep 0.2  # Pause after the complete messages are shown
done
