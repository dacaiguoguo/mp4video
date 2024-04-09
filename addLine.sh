# ffmpeg -y \
# -i background.mp4 \
# -loop 1 -i overlay.png \
# -filter_complex "[1:v]loop=loop=-1:size=1[start]; [0:v][start]overlay=y='t*(H-h)':shortest=1" \
# -t 4 \
# addLineOutput.mp4

ffmpeg -y \
-i background.mp4 \
-loop 1 -i overlay.png \
-filter_complex "[1:v]loop=-1:size=1,setpts=N/FRAME_RATE/TB[v1];[0:v][v1]overlay=x='t*(W-w)':shortest=1" \
-t 4 \
addLineOutputH2.mp4
