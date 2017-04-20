function [newCellArray] = addBulletsToImageArray(oldCellArray, playerBulletList);


global handleGlobals;


bulletId = 2;


% Create variables
playerBulletLength = size(playerBulletList,1);
newCellArray = oldCellArray;

% Loop through every bullet
for k=1:playerBulletLength
    % Find this loop's bullet
    thisBullet = playerBulletList(k,:);
    % Find the number of the bullet
    thisImage = handleGlobals.playerBullets(:,:,:,thisBullet(3)+1);
    % add values to the new cell array
    addedRow = {thisImage, thisBullet(1)+.51, thisBullet(2), -.5, .5, bulletId, thisBullet(5)};
    if playerBulletList(k,4)<0
        disp(':)');
        addedRow = {thisImage, thisBullet(1)+.51, thisBullet(2)+.6, -.5, -.5, bulletId, thisBullet(5)};
    end
    newCellArray = cat(1,newCellArray, addedRow);
end



end