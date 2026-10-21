#!/bin/sh
# Builds the web version of the training video from design/assets/training/.
# Cuts the app outro (starts at 20.47s), moves the index to the front for fast start,
# and exports the poster frame. Needs ffmpeg.
set -e
cd "$(dirname "$0")/.."
SRC=design/assets/training/training-video-original.mp4
mkdir -p public/assets/video public/assets/img
ffmpeg -v error -y -i "$SRC" -t 20.4 -c:v libx264 -crf 23 -preset slow -pix_fmt yuv420p \
  -c:a aac -b:a 96k -movflags +faststart public/assets/video/training.mp4
ffmpeg -v error -y -ss 9 -i "$SRC" -frames:v 1 -c:v libwebp -quality 78 public/assets/img/training-poster.webp
