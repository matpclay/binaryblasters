function varargout = test(varargin)
% TEST MATLAB code for test.fig
%      TEST, by itself, creates a new TEST or raises the existing
%      singleton*.
%
%      H = TEST returns the handle to a new TEST or the handle to
%      the existing singleton*.
%
%      TEST('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST.M with the given input arguments.
%
%      TEST('Property','Value',...) creates a new TEST or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test

% Last Modified by GUIDE v2.5 19-Apr-2017 01:11:26

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% ID LIST:
% 1: player spaceship
% 2: player bullet
% 3: enemy ship
% 4: player bullet Bounced


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)

% Choose default command line output for test
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% Add subfolders
addpath('Sounds');

% Variables
handles.spaceship = imread('spaceship1.png');
global soundState;
handles.playerBullets = cat(4,imread('bullet0.png'),...
                            imread('bullet1.png'),...
                            imread('bullet2.png'),...
                            imread('bullet3.png'),...
                            imread('bullet4.png'),...
                            imread('bullet5.png'),...
                            imread('bullet6.png'),...
                            imread('bullet7.png'));
                        
handles.enemyShips = cat(4,imread('enemyShip0.png'),...
                            imread('enemyShip1.png'),...
                            imread('enemyShip2.png'),...
                            imread('enemyShip3.png'),...
                            imread('enemyShip4.png'),...
                            imread('enemyShip5.png'),...
                            imread('enemyShip6.png'),...
                            imread('enemyShip7.png'));



handles.spaceshipPosition = [0 .25];
guidata(hObject,handles);  
handles.keepRunning = false;
handles.leftButtonDown = false;
handles.rightButtonDown = false;
handles.playerBulletList = zeros(0,5);
handles.enemyShipList = zeros(0,5);

global gameAxis;
gameAxis = [0 10 0 10];
global handleGlobals;
handleGlobals = handles;
global bulletSpeed
bulletSpeed = .35;
global difficultyLevel
difficultyLevel = 1;
global objectsOnScreen
objectsOnScreen = [1];
global livesLeft
livesLeft = 2;
global continueGame
continueGame = true;
global pointCount
pointCount = 0;
global hasDangerZone
hasDangerZone = false;





% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global handleGlobals
global continueGame
global pointCount
collisionList = [];
set(handles.pushbutton1, 'visible', 'off');

while (continueGame)
    
    % UPDATE VARIABLES --------------------------------------------------
    
    % Update rocket positions
    global gameAxis
    
    rocketMoveDistance = .2;
    if handleGlobals.rightButtonDown==true && handleGlobals.spaceshipPosition(1)<gameAxis(2)
        handleGlobals.spaceshipPosition(1)=handleGlobals.spaceshipPosition(1)+rocketMoveDistance;
    elseif handleGlobals.leftButtonDown && handleGlobals.spaceshipPosition(1)>gameAxis(1)
        handleGlobals.spaceshipPosition(1)=handleGlobals.spaceshipPosition(1)-rocketMoveDistance;
    end
    
    % Update player bullets
    handleGlobals.playerBulletList = updatePlayerBullets(handleGlobals.playerBulletList);
    
    % Update enemy ships
    handleGlobals.enemyShipList = updateEnemyShips(handleGlobals.enemyShipList);
    
    % update all based on collisions:
    if ~isempty(collisionList)
        [handleGlobals.playerBulletList,handleGlobals.enemyShipList] = ...
            updateCollisions(collisionList, handleGlobals.playerBulletList,handleGlobals.enemyShipList,handleGlobals.spaceshipPosition);
    end
    
    % Display for debugging
    axes(handles.axes1);
    
    % Create the image needed
    % 1) make list of images to be displayed
    imageArray = {handleGlobals.spaceship handleGlobals.spaceshipPosition(1) handleGlobals.spaceshipPosition(2) .5 .6    1 1};
    imageArray = addBulletsToImageArray(imageArray,handleGlobals.playerBulletList);
    imageArray = addEnemyShipsToImageArray(imageArray,handleGlobals.enemyShipList);
    
    collisionList = checkCollisions(imageArray);
    
    plotImage(imageArray);
    
    % Update points:
    set(handles.pointBox, 'String', num2str(pointCount));
    prizeGiver;
    
    % Delay
    handles = handleGlobals;
    frameDelay = .025;
    pause(frameDelay);
end

% --- Executes on key press with focus on figure1 or any of its controls.
function figure1_WindowKeyPressFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)

% GET KEYBOARD INPUTS
global handleGlobals;
global bulletSpeed;
global objectsOnScreen
Char = eventdata.Key;
switch Char
    case {'rightarrow'}
        handleGlobals.rightButtonDown = true;
    case {'leftarrow'}
        handleGlobals.leftButtonDown = true;
    case {'0','1','2','3','4','5','6','7'}
        if size(handleGlobals.playerBulletList,1)<3
            newObjectId = max(objectsOnScreen)+1;
            objectsOnScreen = [objectsOnScreen, newObjectId];
            handleGlobals.playerBulletList = cat(1,handleGlobals.playerBulletList,[handleGlobals.spaceshipPosition, str2num(Char), bulletSpeed, newObjectId]);
            if (soundState)
                [y, Fs] = audioread('Galaga_Firing.wav');
                sound(y, Fs);
            end
        end
end
handles = handleGlobals;
guidata(hObject,handles);


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);





% --- Executes on key release with focus on figure1 or any of its controls.
function figure1_WindowKeyReleaseFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.FIGURE)
%	Key: name of the key that was released, in lower case
%	Character: character interpretation of the key(s) that was released
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) released
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global handleGlobals;
Char = eventdata.Key;
switch Char
    case {'rightarrow'}
        handleGlobals.rightButtonDown = false;
    case {'leftarrow'}
        handleGlobals.leftButtonDown = false;
end 
handles = handleGlobals;
guidata(hObject,handles);
