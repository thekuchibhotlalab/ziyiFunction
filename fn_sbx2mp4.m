filename = 'kimtech_001_001';
% create the video writer with 1 fps
writerObj = VideoWriter([filename '_movie.avi']);
writerObj.FrameRate = 15.63;
% set the seconds per image
% open the video writer
open(writerObj);
% write the frames to the video
sbxread(filename,1,1);
global info;
mat = sbxread(filename,1,info.max_idx);
mat = permute(mat,[2 3 1 4]);
writeVideo(writerObj, double(mat)/65536);
close(writerObj);