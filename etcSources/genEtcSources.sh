#!/usr/bin/env bash

# assumes cd'd into etcSources directory
# $1: outputs dir
# $2: etcSources dir

outputs="$1"
etcSources="$2"

cp "$etcSources/mapgen/index.html" "$outputs/mapgen.html"
rm -r "$outputs/images"
cp -r "$etcSources/images" "$outputs/images"
