#!/bin/bash


PORT=5000

wget --recursive \
     --level 2 \
     --no-clobber \
     --page-requisites \
     --adjust-extension \
     --convert-links \
     localhost:${PORT}
