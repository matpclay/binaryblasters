function [newCellArray] = addEnemyShipsToImageArray(oldCellArray, enemyShipList);


global handleGlobals;

shipId = 3;

% Create variables
enemyShiptLength = size(enemyShipList,1);
newCellArray = oldCellArray;

% Loop through every bullet
for k=1:enemyShiptLength
    % Find this loop's bullet
    thisShip = enemyShipList(k,:);
    % Find the number of the ship
    thisImage = handleGlobals.enemyShips(:,:,:,thisShip(3)+1);
    % add values to the new cell array
    newCellArray = cat(1,newCellArray, {thisImage, thisShip(1)+.74, thisShip(2), 1, -1, shipId, thisShip(5)});
end



end