function [collisionList] = checkCollisions(array)
% checks for collisions in a cell array in form:
% array = [image1 xPos1 yPos1 width1 height1 TypeID1 objectNumber1...
%          image2 xPos2 yPos2 width2 height2 TypeID2 objectNumber2...
%          ...
%          imageN xPosN yPosN widthN heightN TypeIDN objectNumberN]


% Returned in form of: [TypeID1 TypeID2 objectNumber1 objectNumber2]
collisionList = zeros(0,4);

for k1 = 2:size(array,1)-1
    xPos1 = array{k1,2};
    yPos1 = array{k1,3};
    width1 = array{k1,4};
    height1 = array{k1,5};
    picture1 = array{k1,1};
    typeId1 = array{k1,6};
    objectId1 = array{k1,7};
    
    for k2 = 1:(k1-1)
        xPos2 = array{k2,2};
        yPos2 = array{k2,3};
        width2 = array{k2,4};
        height2 = array{k2,5};
        picture2 = array{k2,1};
        typeId2 = array{k2,6};
        objectId2 = array{k2,7};
        
        if typeId1 ~= typeId2
            % find edges:
            
            % FIRST
            % sides
            if width1>0
                leftEdge1 = xPos1;
                rightEdge1 = xPos1+width1;
            else
                leftEdge1 = xPos1+width1;
                rightEdge1 = xPos1;
            end
            % top and bottom
            if height1>0
                topEdge1 = yPos1;
                bottomEdge1 = yPos1+height1;
            else
                topEdge1 = yPos1+height1;
                bottomEdge1 = yPos1;
            end
            
            % SECOND
            % sides
            if width2>0
                leftEdge2 = xPos2;
                rightEdge2 = xPos2+width2;
            else
                leftEdge2 = xPos2+width2;
                rightEdge2 = xPos2;
            end
            % top and bottom
            if height2>0
                topEdge2 = yPos2;
                bottomEdge2 = yPos2+height2;
            else
                topEdge2 = yPos2+height2;
                bottomEdge2 = yPos2;
            end
            
                
            if (  (leftEdge1>leftEdge2) && (leftEdge1<rightEdge2)  ) || (  (rightEdge1>leftEdge2) && (rightEdge1<rightEdge2)  )...
             ||(  (leftEdge2>leftEdge1) && (leftEdge2<rightEdge1)  ) || (  (rightEdge2>leftEdge1) && (rightEdge2<rightEdge1)  )
                if (  (topEdge1>topEdge2) && (topEdge1<bottomEdge2)  ) || (  (bottomEdge1>topEdge2) && (bottomEdge1<bottomEdge2)  )...
                 ||(  (topEdge1>topEdge2) && (topEdge1<bottomEdge2)  ) || (  (bottomEdge1>topEdge2) && (bottomEdge1<bottomEdge2)  )
                    collisionList = cat(1,collisionList,[typeId1, typeId2, objectId1, objectId2]);
                    str = sprintf('%d',[typeId1, typeId2]);
                    switch str
                        case {'14','41'}
                            disp('IT WORKS');
                        case {'13','31'}
                            disp('YOU DEAD!');
                        case {'23','32'}
                            disp('You got them!');
                    end
                end
            end
        end
    end
    
end

end