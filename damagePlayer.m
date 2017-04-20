function [] = damagePlayer()
% Drops a life from the player and kills if the player runs out of lives.

global livesLeft
global handleGlobals
global continueGame
damageNotificationDelay = 1;

% Drop the livesLeft
livesLeft = livesLeft-1;
switch(livesLeft)
    case 2
        handleGlobals.spaceship = imread('spaceship1.png');
    case 1
        handleGlobals.spaceship = imread('spaceship2.png');
        image([0 10],[0 10],imread('damage1left.png'));
        frameDelay = 1;
        pause(damageNotificationDelay);
    case 0
        handleGlobals.spaceship = imread('spaceship3.png');
        image([0 10],[0 10],imread('damage0left.png'));
        frameDelay = 1;
        pause(damageNotificationDelay);
    case -1
        axes(handleGlobals.axes1);
        image([0 10],[0 10],imread('gameOverScreen.png'));
        pause(damageNotificationDelay);
        continueGame = false;
        % close the game gui
        close; clear; clc;
end