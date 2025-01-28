#!/bin/bash

input_file="$1"
output_file="$2"
overlay_text="DRAFT"

dimensions=$(identify -format "%w %h" "$input_file")
width=$(echo $dimensions | cut -d' ' -f1)
height=$(echo $dimensions | cut -d' ' -f2)

smaller_dim=$((width < height ? width : height))

text_length=${#overlay_text}
scaling_factor=1
point_size=$((smaller_dim / (text_length * scaling_factor)))

magick "$input_file" \
	-family "Noto Sans" \
	-weight Bold \
	-pointsize $point_size \
	-fill "rgba(255,0,0,0.3)" \
	-gravity center \
	-annotate -15 "$overlay_text" \
	"$output_file"
