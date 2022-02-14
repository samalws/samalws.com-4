#!/usr/bin/env bash

# $1: sources dir, defaults to "sources"
# $2: outputs dir, defaults to "outputs"

if [ -z "$1" ]; then
  sources=sources
else
  sources="$1"
fi

if [ -z "$2" ]; then
  outputs=outputs
else
  outputs="$2"
fi

myDir=$(dirname $0)

for dir in $(cd "$sources"; find . -type d); do
  mkdir -p "$outputs/$dir"
done

rm -r "$outputs/resources"
cp -r "$myDir/resources" "$outputs/resources"

repl="./$myDir/replace.py"

for file in $(cd "$sources"; find . -type f -name "*.html"); do
  dir=$(dirname "$sources/$file")
  relpath=$(realpath --relative-to="$dir" "$sources")
    title=$(cat "$sources/$file" | head -1)
   header=$(cat "$sources/$file" | tail +2 | head -1)
  content=$(cat "$sources/$file" | tail +3)
  fileContents=$(cat "$sources/$file")
  cat "$myDir/template.html" | "$repl" PATH "$relpath" | "$repl" TITLE "$title" | "$repl" HEADER "$header" | "$repl" CONTENT "$content" > "$outputs/$file"
done
