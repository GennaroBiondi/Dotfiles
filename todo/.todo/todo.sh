#!/usr/bin/sh
script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
file="$script_dir/todo.list"

cmd="$1"

if [ "$cmd" = "reset" ]; then
    sed -i 's/\[x\]/[ ]/g' "$file"
elif [ "$cmd" = "skip" ]; then
    sed -i 's/\[ ]/[.]/g' "$file"
elif [ "$cmd" = "done" ]; then
    sed -i 's/\[ ]/[x]/g' "$file"
    sed -i 's/\[.\]/[x]/g' "$file"
else
    echo "Invalid command $cmd"
fi
