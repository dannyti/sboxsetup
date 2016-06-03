#!/bin/bash
for i in *.wmv; 
do mtn "${i}" -f ~/usr/share/fonts/truetype/liberation/LiberationMono-Bold.ttf -c 3 -r 3 -s 300;
done;
for i in *.mkv;
do mtn "${i}" -f ~/usr/share/fonts/truetype/liberation/LiberationMono-Bold.ttf -c 3 -r 3 -s 300;
done;
for i in *.mp4;
do mtn "${i}" -f ~/usr/share/fonts/truetype/liberation/LiberationMono-Bold.ttf -c 3 -r 3 -s 300;
done;
