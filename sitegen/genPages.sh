#!/usr/bin/env sh

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

cp -r "$myDir/resources" "$outputs/resources"

for file in $(cd "$sources"; find . -type f -name "*.html"); do
  dir=$(dirname "$sources/$file")
  relpath=$(realpath --relative-to="$dir" "$sources")
  cat "$sources/$file" | "./$myDir/genPage.py" "$myDir/template.html" "$relpath" > "$outputs/$file"
done
