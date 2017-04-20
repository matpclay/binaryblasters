function [] = plotImage(array)
% Plots all images in a cell array in form:
% array = [image1 xPos1 yPos1 width1 height1 TypeID1 objectNumber1...
%          image2 xPos2 yPos2 width2 height2 TypeID2 objectNumber2...
%          ...
%          imageN xPosN yPosN widthN heightN TypeIDN objectNumberN]

global gameAxis;

cla('reset');
axis(gameAxis);

hold on;
set(gca,'Color',[0 0 0]);
for k=1:size(array,1)
    xPos = array{k,2};
    yPos = array{k,3};
    width = array{k,4};
    height = array{k,5};
    picture = array{k,1};
    image([xPos xPos+width], [yPos yPos+height], picture);
%     plot(xPos,yPos,'w*');
%     plot(xPos+width,yPos+height,'w*');

end
hold off;

end