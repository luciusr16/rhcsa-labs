#!/bin/bash  

#function for clean and consistent error messages, without the need for loads of "if" statements 
die() { echo "ERROR: $1" >&2
exit 1
}

#enforces only one argument from the user, and if not then it shows how to use the script
[[ $# -ne 1 ]] && die  "usage $0 <file-pattern>"

# to validate that the /home directory exists
[[ ! -d /home ]] && die " /home directory is missing"

# declaring an array here to store all matched files found 
declare -a files=()


#using a while loop to loop through all files matching the pattern the user provided and adding them to the array 
while IFS= read -r file; do
        files+=("$file")
done < <(find /home -type f -name $1 >&2)

# this checks if the "find"  command above encountered an error with the help of the exit status 
[[ $? -ne 0 ]] && die "an error occured in the file search"

# counting and displaying results of the array in a variable called count 
count=${#files[@]}

echo "found $count matching files in /home and its subdirectories" 


~                                                             
~                                                             
~                                                             
