#!/bin/sh
# Script to manually compile and update the notes

echo "Updating and installing packages"
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y pandoc texlive-latex-recommended texlive-latex-extra texlive-xetex
echo Converting files
mkdir -p pdf
pandoc -s notes.md -o ./pdf/notes.tex --pdf-engine=xelatex
pandoc -s ./pdf/notes.tex -o ./pdf/notes.pdf --pdf-engine=xelatex