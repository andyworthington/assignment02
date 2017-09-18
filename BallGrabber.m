clc;clear;close all;
% colorThresholder
rgb = imread('img001.jpg');
startingFrame = 1;
endingFrame = 489;

BlueXcentroid = [];
BlueYcentroid = [];
RedXcentroid = [];
RedYcentroid = [];
SoccerXcentroid = [];
SoccerYcentroid = [];
for k = startingFrame : endingFrame
rgb = imread(['balls/' sprintf('img%2.3d.jpg', k)]);
hsv = rgb2hsv(rgb);

[BlueBW, ~] = createMaskBlueBall(rgb);
BlueSE = strel('disk', 5,0);
BlueIopen = imopen(BlueBW, BlueSE);
BlueSE = strel('disk', 5,0);
BlueIclose = imclose(BlueIopen, BlueSE);
[Bluelabels, Bluenumber] = bwlabel(BlueIclose, 8);

[RedBW,  ~] = createMaskRedBall(rgb);
RedSE = strel('disk', 4,0);
RedIopen = imopen(RedBW, RedSE);
RedSE = strel('disk', 4,0);
RedIclose = imclose(RedIopen, RedSE);
[Redlabels, Rednumber] = bwlabel(RedIclose, 8);

[SoccerBW, ~] = createMaskSoccerBall(rgb);
SoccerSE = strel('disk', 5,0);
SoccerIopen = imopen(SoccerBW, SoccerSE);
SoccerSE = strel('disk', 5,0);
SoccerIclose = imclose(SoccerIopen, SoccerSE);
[Soccerlabels, Soccernumber] = bwlabel(SoccerIclose, 8);

imshow(rgb, 'border', 'tight')

if(Bluenumber > 0)
BlueIstats = regionprops(Bluelabels, 'basic', 'Centroid');
[BluemaxVal, BluemaxIndex] = max([BlueIstats.Area]);

hold on;
BlueXcentroid = [BlueXcentroid BlueIstats(BluemaxIndex).Centroid(1)];
BlueYcentroid = [BlueYcentroid BlueIstats(BluemaxIndex).Centroid(2)];
end
plot(BlueXcentroid, BlueYcentroid, 'bo', 'Linewidth', 1.5);

if(Rednumber > 0)
RedIstats = regionprops(Redlabels, 'basic', 'Centroid');
[RedmaxVal, RedmaxIndex] = max([RedIstats.Area]);

hold on;
RedXcentroid = [RedXcentroid RedIstats(RedmaxIndex).Centroid(1)];
RedYcentroid = [RedYcentroid RedIstats(RedmaxIndex).Centroid(2)];

 
end
plot(RedXcentroid, RedYcentroid, 'ro', 'Linewidth', 1.5);

if(Soccernumber > 0)
SoccerIstats = regionprops(Soccerlabels, 'basic', 'Centroid');
[SoccermaxVal, SoccermaxIndex] = max([SoccerIstats.Area]);

hold on;
SoccerXcentroid = [SoccerXcentroid SoccerIstats(SoccermaxIndex).Centroid(1)];
SoccerYcentroid = [SoccerYcentroid SoccerIstats(SoccermaxIndex).Centroid(2)];
end
plot(SoccerXcentroid, SoccerYcentroid, 'wo', 'Linewidth', 1.5);

pause(0.00001)
if(mod(k,5) == 0)
    clf;
end
end
