function [] = prizeGiver()
% rewards player once get a certain point level

global pointCount
global hasDangerZone
global soundState
if pointCount>=300 && ~hasDangerZone
    disp('PLAY SONG')
    hasDangerZone = true;
    if (soundState)
        [y, Fs] = audioread('dangerZone.wav');
        sound(y, Fs);
    end
    image([0 10],[0 10],imread('dangerZone.png'));
    pause(2);
end