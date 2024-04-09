# # 垂直线 水平移动
# ffmpeg -y \
# -loop 1 -i image1.jpg \
# -loop 1 -i image2.jpg \
# -filter_complex "[0:v][1:v]blend=all_expr='if(lte(T,2), B*if(gte(X,W*T/2),1,0)+A*if(gte(X,W*T/2),0,1), B*if(lte(X,W*(1-(T-2)/2)),0,1)+A*if(lte(X,W*(1-(T-2)/2)),1,0))':shortest=1" \
# -t 4 -c:v libx264 output.mp4

ffmpeg -y \
-loop 1 -i image1.jpg \
-loop 1 -i image2.jpg \
-loop 1 -i overlay.png \
-filter_complex "\
[0:v][1:v]blend=all_expr='if(lte(T,2), B*if(gte(X,W*T/2),1,0)+A*if(gte(X,W*T/2),0,1), B*if(lte(X,W*(1-(T-2)/2)),0,1)+A*if(lte(X,W*(1-(T-2)/2)),1,0))'[blended]; \
[2:v]format=rgba,loop=-1:size=1,setpts=N/FRAME_RATE/TB[overlay]; \
[blended][overlay]overlay=x='if(lte(T,2),W*T/2-10, W-(W*(1-(T-2)/2))-10)':shortest=1" \
-t 4 -c:v libx264 output_with_overlay.mp4
