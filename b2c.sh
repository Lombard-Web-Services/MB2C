#!/bin/bash
# By Thibaut LOMBARD (LombardWeb)
# list all filename with specific extension in a folder and store the results in an array
declare -a files  # Declare an array
shopt -s nullglob # Prevents array from containing pattern if no matches

# Default values
extension="bin"
input_folder=$(pwd)
output_file="output.cue"

# Function to display help
show_help() {
    echo "This script permit to create a .cue index file from a list of .bin files for PSX or PS1 disk images to PSVITA. for a later use with binmerge and psxtopsp."
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -i <path>    Specify input folder path"
    echo "  -o <file>    Specify output file name"
    echo "  -h           Display this help message"
    echo "Example: $0 -i /path/to/folder -o output.cue"
}

# Parse command-line arguments
while [ $# -gt 0 ]; do
    case "$1" in
        -i)
            input_folder="$2"
            shift 2  # Skip the option and its argument
            ;;
        -o)
            output_file="$2"
            shift 2
            ;;
        -h)
            show_help
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            exit 1
            ;;
    esac
done

# Check if input folder was provided
if [ -z "$input_folder" ]; then
    echo "By default, selected directory is $input_folder you can choose it using the (-i) argument"
fi
# Check if output file was provided
if [ -z "$output_file" ]; then
    echo "No output file is specified you can setup it with (-o) argument, default is $output_file"
fi
# Store files in array
files=("$input_folder"/*."$extension")

# Optional: Print the array to verify
#printf '%s\n' "${files[@]}"

# For each element in an array write the cuesharp data file

# Clear the file first (optional, remove if you want to append instead)
> "$output_file"
# Count number of elements
count=${#files[@]}
echo -e "$count bin files found, Indexing into $output_file ..."

# Loop from 0 to count-1
for ((i=0; i<$count; i++)); do
	# removing suffix from file
	path=${files[$i]}
	# fileWOs is filename without suffix
	fileWOs=${path##*/}
 #remove the O'th in i var
 setnewivar=$(($i+1))
 # Number pad to 2 digits the i var
 printf -v padded_count "%02d" "$setnewivar"
  if [ $i -eq 0 ]; then
   echo -e "FILE \"$fileWOs\" BINARY\n  TRACK $padded_count MODE2/2352\n    INDEX 01 00:00:00" >> "$output_file"
    else
   echo -e "FILE \"$fileWOs\" BINARY\n  TRACK $padded_count AUDIO\n    INDEX 00 00:00:00\n    INDEX 01 00:02:00" >> "$output_file"
  fi
done
#name the binmerge bin extension
namebinmerged="${output_file%.*}"
echo -e "\n$output_file successfully generated !\n"
# Method 1: Simple read with if
read -p "Do you want to merge all your bin files into one ? (y/n): " answer
if [ "$answer" = "y" ] || [ "$answer" = "Y" ]; then
    echo -e "\nYour files "$namebinmerged"_img.bin and "$namebinmerged"_img.cue  are generating.."
    # Place your command here
    ./binmerge $output_file $namebinmerged"_img" > /dev/null 2>&1
    echo -e "\nIt is now possible to generate your eboot via psx2psp.exe\n\nThank you for using my script."
else
    echo "Good Bye"
    exit 0
fi

