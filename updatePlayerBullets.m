function [newPositions] = updatePlayerBullets(oldPositions)
% Takes the old positions of the bullets and updates their positions. Also
% deletes bullets no longer on screen.
%
% Usage: >> [newPositions] = updatePlayerBullets(oldPositions)
global gameAxis;
global objectsOnScreen;

if ~isempty(oldPositions)
    newPositions = zeros(0,5);
    % Variables
    topBoundary = gameAxis(4);
    bottomBoundary = gameAxis(3);
    safetyBoundary = 2;

    length = size(oldPositions,1);
    for k=1:length
        distancePerFrame = oldPositions(k,4);
        if oldPositions(k,2)<topBoundary+safetyBoundary && oldPositions(k,2)>bottomBoundary-safetyBoundary
            newPositions(end+1,:) = oldPositions(k,:)+[0 distancePerFrame 0 0 0];
        else
            objectsOnScreen = objectsOnScreen( objectsOnScreen~=oldPositions(k,5) );
        end
    end
else
    newPositions = oldPositions;
end


end