

load('posArr1') % Remember to save posArr1 to folder to load it

[Rmat,Cmat]=myTracking(posArr1(1,1:2347),50,0);


figure()
imagesc(Rmat)

%%
figure()
hold on
for i=1:18
    r=Rmat(i,:); c=Cmat(i,:);
    r=r(r~=0); c=c(c~=0);
    plot(r,c)

end


%%

% Use this to configure the cropping for the video

% figure()
% for t=1:255
%     L=60;
% 
%     img = imread('test1.tif',t);
%     fh = figure;
%     imshow( img, 'border', 'tight' ); %//show your image
%     hold on;
%     for i=1:17
%         rectangle('Position', [Rmat(i,t)-30 Cmat(i,t)-30 L L] ); %// draw rectangle on image
%         text(Rmat(i,t),Cmat(i,t),int2str(i),"FontSize",20,"Color","yellow")
%     end
%     frm = getframe( fh ); %// get the image+rectangle
%     imwrite( frm.cdata, 'boxes.png' ); %// save to file
% 
%     imshow('boxes.png')
%     pause(0.1)
% 
% end

%%

% Rotational Speed finder
L=60;
FF=1680;

figure()
freq=zeros(17,FF);
metric = registration.metric.MeanSquares;
optimizer = registration.optimizer.RegularStepGradientDescent;
for i=[4,15]
    for t=1:FF
        im=imread('test1.tif',t);
        icrop=imcrop(im,[Rmat(i,t)-30 Cmat(i,t)-30 L L]);
        im2=imread('test1.tif',t+1);
        icrop2=imcrop(im2,[Rmat(i,t+1)-30 Cmat(i,t+1)-30 L L]);
        tform = imregtform(icrop2,icrop,'rigid',optimizer,metric);
        rot = tform.RotationAngle; % Rot is in degrees for some reason
        freq(i,t) = (rot)/(3.2*180*360); 
    end
end

%%

% Calculations

% load('freq')
% x=linspace(1,FF,FF);
% plot(x,freq)
% 
% 
% % Plot frequency for all trajectories
% x = linspace(1, FF, FF);
% plot(x, freq)
% 
% % Extract relevant sections of frequencies
% somefreq = freq(4, 700:1130);
% somefreq2 = freq(15, 700:1130);
% 
% % Sum frequencies for each trajectory
% sigma = sum(somefreq, 2);
% sigma2 = sum(somefreq2, 2);
% 
% % Calculate average frequencies for trajectories 4 and 15
% avgfreq1 = (sigma(1) * 30) / 430;
% avgfreq2 = (sigma2(1) * 30) / 430;
% 
% % Position Calculations
% xsquared4 = Rmat(4, 255:700).^2;
% ysquared4 = Cmat(4, 255:700).^2;
% 
% xsquared15 = Rmat(15, 255:700).^2;
% ysquared15 = Cmat(15, 255:700).^2;
% 
% r4 = sqrt(xsquared4 + ysquared4);
% r15 = sqrt(xsquared15 + ysquared15);
% 
% % Calculate radial velocities and frequencies
% rdot4 = diff(r4) * 30;
% rdot15 = diff(r15) * 30;
% 
% f04 = rdot4 / ((0.2013 - 0.078) * 2 * pi);
% f015 = rdot15 / ((0.078 - 0.2013) * 2 * pi);
% 
% % Average radial frequencies
% avgf4 = mean(f04);
% avgf15 = mean(f015);



%%


% vidObj = VideoReader("output_short.mp4");
% vidArr=cell(1,100);
% 
% for t=1:377
%     vidFrame = readFrame(vidObj);
%     vidArr{t}=vidFrame;
% end

%%

% vid = VideoWriter('newfile.avi','Motion JPEG AVI');
% % vid.Quality=95;
% vid.FrameRate = 10;
% open(vid);


% figure('Position',[100 100 1200 500])
% figure()
% for t=1:100
% 
%     vidFrame = readFrame(vidObj,t);
% 
%     im=imread('test.tif',t);
%     for k=1:3
%         subplot(1,3,k)
%         imshow(vidArr{t}(:,:,3));
%         hold on
%         L=50;
%         for i=1:3
%             r0=Rmat(i,t); c0=Cmat(i,t);
%             plot(r0+[-1 1 1 -1 -1]*L,c0+[1 1 -1 -1 1]*L,'r')
%         end
% 
%     frame = getframe(gcf);
%     writeVideo(vid,frame);
%     clf
%     end
% end
% 
% close(vid)