#!/data/data/com.termux/files/usr/bin/bash

# default output file name
output_file="output.mp3"

# usage function
usage() {
  echo "Usage: combine.sh [-o output_file] audio_file1 audio_file2 [audio_file3 ...]"
  echo "Options:"
  echo "  -o output_file  specify the output file name (default: output.mp3)"
  echo "  -h              display this help message"
}

# parse command line arguments
while getopts "o:h" opt; do
  case $opt in
    o)
      output_file="$OPTARG"
      ;;
    h)
      usage
      exit 0
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      exit 1
      ;;
  esac
done

# remove the parsed options
shift $((OPTIND-1))

# check if there are enough arguments
if [ $# -lt 2 ]; then
  echo "Error: At least 2 audio files must be specified." >&2
  usage
  exit 1
fi

# Get the list of input files
input_files=("$@")

# Concatenate the input files
input_string=$(printf "|%s" "${input_files[@]}")
input_string="${input_string:1}"

ffmpeg -i "concat:$input_string" -c copy "$output_file"