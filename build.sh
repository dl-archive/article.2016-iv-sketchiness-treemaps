#!/usr/bin/env bash
# Reproducible build with the TeX Live version closest to the original (MiKTeX, pdfTeX 1.40.14 → TeX Live 2013).
# Requires podman (or docker: export ENGINE=docker). Output: build/main.pdf
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2013-historic
mkdir -p build
"$ENGINE" run --rm -e openout_any=a -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" -w /src "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -outdir=/out main.tex
