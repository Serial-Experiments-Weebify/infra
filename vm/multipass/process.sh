#!/usr/bin/env bash

# Simple preprocessor that processes '##include <filename>' directives

input_file="$1"
output_file="$2"

if [ $# -ne 2 ]; then
  echo "Usage: $0 <input_file> <output_file>" >&2
  exit 1
fi

process_file() {
  local file="$1"
  local prefix="$2"
  
  if [ ! -f "$file" ]; then
    echo "Error: File not found - $file" >&2
    return 1
  fi

  while IFS= read -r line; do
    if [[ $line =~ ^([[:space:]]*)##include[[:space:]]+(.+)$ ]]; then
      local leading="${BASH_REMATCH[1]}"
      local include_file="${BASH_REMATCH[2]}"
      process_file "$include_file" "$prefix$leading"
    else
      echo "${prefix}${line}"
    fi
  done < "$file"
}
process_file "$input_file" > "$output_file"
echo "Processed $output_file" >&2