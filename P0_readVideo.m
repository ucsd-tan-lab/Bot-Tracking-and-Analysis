vidObj = VideoReader("Botvid1.mp4");

nf=0;

while hasFrame(vidObj)
    vidFrame = readFrame(vidObj);
    I = rgb2gray( vidFrame );

    imwrite(I, 'test1.tif','WriteMode','Append')
    %imshow(I)
    %pause(1/vidObj.FrameRate)
end

%%

Nt=vidObj.FrameRate*vidObj.Duration;

% figure()
% 
% posArr1=cell(1,Nt);
% radiusArr=cell(1,Nt);
% 
% for t=1:Nt
%     im=imread('test1.tif',t);
% 
%     [centers,radii,metric] = imfindcircles(im,[25 60]);
% 
%     imshow(im)
%     hold on
% 
%     posArr1{t}=centers';
%     radiusArr{t}=radii;
% 
%     for i=1:length(radii)
%         viscircles(centers(i,:), radii(i),'Color','r');
%         text(centers(i,1),centers(i,2),int2str(i),'color','y','HorizontalAlignment', 'center','VerticalAlignment', 'middle');
%     end
%     pause(0.1)
% 
% 
% end