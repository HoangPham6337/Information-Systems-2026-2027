#!/bin/sh
# Rebuild the magazine figures: ./build.sh
cd "$(dirname "$0")" || exit 1
i=0
for n in magazine_step_2 magazine_link magazine_step_4 magazine_schema; do
  pdflatex -interaction=nonstopmode -jobname="$n" "\def\fig{$i}\input{magazine_figs.tex}" >/dev/null || { echo "FAIL $n"; exit 1; }
  mv "$n.pdf" ..
  i=$((i+1))
done
rm -f *.aux *.log
