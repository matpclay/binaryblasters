function [newPositions] = updateEnemyShips(oldPositions)
% Takes the old positions of the bullets and updates their positions. Also
% deletes bullets no longer on screen.
%
% Usage: >> [newPositions] = updatePlayerBullets(oldPositions)


% Variables
global gameAxis;
global difficultyLevel;
global objectsOnScreen;
global pointCount
chanceNewShip = .05;
length = size(oldPositions,1);

bottomBoundary = gameAxis(3);
topBoundary = gameAxis(4);
safetyBoundary = 2;

if ~isempty(oldPositions)
    newPositions = zeros(0,5);

    for k=1:length
        distancePerFrame = oldPositions(k,4);
        if oldPositions(k,2)>bottomBoundary-safetyBoundary
            newPositions(end+1,:) = oldPositions(k,:)+[0 distancePerFrame 0 0 0];
        else
            objectsOnScreen = objectsOnScreen( objectsOnScreen~=oldPositions(k,5) );
            pointCount = pointCount-oldPositions(k,3);
        end
    end
    
    
else
    newPositions = oldPositions;
end

% Chance of generating new ship
randomNumber = rand();
shipLimit = 4+difficultyLevel;

if randomNumber < chanceNewShip && length < shipLimit
    % Find new ship parameters
    shipPositionX = rand()*9;
    shipNumber = floor(rand*8);
    newObjectId = max(objectsOnScreen)+1;
    objectsOnScreen = [objectsOnScreen newObjectId];
    % varying ship speed between -.05 and -.1
    shipSpeed = .05*rand-.1;

    % Generate new ship in array
    newPositions(end+1,:) = [shipPositionX topBoundary+safetyBoundary shipNumber shipSpeed newObjectId];

end

end