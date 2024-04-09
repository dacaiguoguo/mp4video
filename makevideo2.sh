# 水平分割线 垂直移动
ffmpeg -y \
-loop 1 -i image1.jpg \
-loop 1 -i image2.jpg \
-filter_complex "[0:v][1:v]blend=all_expr='if(lte(T,2), B*if(gte(Y,H*T/2),1,0)+A*if(gte(Y,H*T/2),0,1), B*if(lte(Y,H*(1-(T-2)/2)),0,1)+A*if(lte(Y,H*(1-(T-2)/2)),1,0))':shortest=1" \
-t 4 -c:v libx264 output.mp4
