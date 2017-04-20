function [bulletList,enemyList] = updateCollisions(collisionList, bulletList,enemyList,shipPosition)
% Takes the bulletList and enemyList and shipPosition and returns updated
% versions of the ships based on the collisions


global objectsOnScreen;
global pointCount;
global soundState;
% Loop through every collision.
collisionCount = size(collisionList,1);
disp(collisionList);
for k=1:collisionCount
    % concatenate collisionType into string the id
    collisionType = [num2str(collisionList(k,1)),num2str(collisionList(k,2))];
    switch collisionType
        case {'12','21'}
            % Determine variables about the bullet
            if collisionType == '12'
                bulletObjectId = collisionList(k,4);
            else
                bulletObjectId = collisionList(k,3);
            end
            thisBulletRow = find(bulletList(:,5)==bulletObjectId);
            thisBulletVelocity = bulletList(thisBulletRow, 2);
            if thisBulletVelocity<0
                bulletList = bulletList([1:thisBulletRow-1,thisBulletRow+1:end],:)
                objectsOnScreen = objectsOnScreen( objectsOnScreen~=bulletObjectId );
                damagePlayer();
            end
            
        case {'13','31'}
            % An enemy ship hits the player
            damagePlayer();
            
            % Find object Id's
            if collisionType == '13'
                shipObjectId = collisionList(k,4);
            else
                shipObjectId = collisionList(k,3);
            end
            
            
            % Delete ship from shipList
            thisEnemyRow = find(enemyList(:,5)==shipObjectId);
            enemyList = enemyList([1:thisEnemyRow-1,thisEnemyRow+1:end],:);
            objectsOnScreen = objectsOnScreen( objectsOnScreen~=shipObjectId );
            
        case {'23','32'}
            % A bullet hits a ship
            % get bullet and ship ID
            if collisionType == '23'
                bulletObjectId = collisionList(k,3);
                shipObjectId = collisionList(k,4);
            else
                bulletObjectId = collisionList(k,4);
                shipObjectId = collisionList(k,3);
            end
            % Find the bullet and enemy rows
            thisBulletRow = find(bulletList(:,5)==bulletObjectId);
            thisEnemyRow = find(enemyList(:,5)==shipObjectId);
            
            % Find out whether the bullet matches the ship
            thisBulletNumber = bulletList(thisBulletRow, 3);
            thisEnemyNumber = enemyList(thisEnemyRow, 3);
            
            % Case whether bullet matches ship or not
            if thisBulletNumber==thisEnemyNumber
                enemyList = enemyList([1:thisEnemyRow-1,thisEnemyRow+1:end],:)
                bulletList = bulletList([1:thisBulletRow-1,thisBulletRow+1:end],:)
                objectsOnScreen = objectsOnScreen( objectsOnScreen~=shipObjectId );
                objectsOnScreen = objectsOnScreen( objectsOnScreen~=bulletObjectId );
                if (soundState)
                    [y, Fs] = audioread('wilhelm.wav');
                    sound(y, Fs);
                end
                pointCount = pointCount+10+thisEnemyNumber;
            else
                if bulletList(thisBulletRow,4)>0
                    bulletList(thisBulletRow,4)= -1*bulletList(thisBulletRow,4)+enemyList(thisEnemyRow,4);
                    %[y, Fs] = audioread('bounce.wav');
                    %sound(y, Fs);
                end
            end
    end
end



end