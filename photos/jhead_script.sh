#!/bin/bash
# for i in `ls IMG*`; do
# 	convert IMG_0789.JPG -resize 2000 IMG_0789.JPG
# done;
./jhead -autorot *
./jhead -n%Y-%m-%d *
./jhead -ft *