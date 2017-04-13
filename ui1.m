function varargout = ui1(varargin)
% UI1 MATLAB code for ui1.fig
%      UI1, by itself, creates a new UI1 or raises the existing
%      singleton*.
%
%      H = UI1 returns the handle to a new UI1 or the handle to
%      the existing singleton*.
%
%      UI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UI1.M with the given input arguments.
%
%      UI1('Property','Value',...) creates a new UI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ui1

% Last Modified by GUIDE v2.5 13-Apr-2017 09:37:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ui1_OpeningFcn, ...
                   'gui_OutputFcn',  @ui1_OutputFcn, ...
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


% --- Executes just before ui1 is made visible.
function ui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ui1 (see VARARGIN)

% Choose default command line output for ui1
handles.output = hObject;
set(handles.mainmenu, 'visible', 'on');
set(handles.optionsmenu, 'visible', 'off');
set(handles.testPanel, 'visible', 'off');
global fsize;
fsize = 18;
global soundState;
soundState = true;
[y, Fs] = audioread('8d82b5_Galaga_Theme_Song.mp3');
sound(y, Fs);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ui1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% TODO: Add gameplay
% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global soundState;
if (soundState)
    [y, Fs] = audioread('8d82b5_Galaga_Level_Start_Sound_Effect.mp3');
    sound(y, Fs);
end

% --- Executes on button press in options.
function options_Callback(hObject, eventdata, handles)
% hObject    handle to options (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% switch menus
set(handles.mainmenu, 'visible', 'off');
set(handles.testPanel, 'visible', 'off'); % protective code
set(handles.optionsmenu, 'visible', 'on');



% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close; clear; clc;

% --- Executes on button press in fontsizeup.
function fontsizeup_Callback(hObject, eventdata, handles)
% hObject    handle to fontsizeup (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fsize;
if (fsize <= 32)
    fsize = fsize + 2;
end
set(handles.soundoption, 'FontSize', fsize);
set(handles.fstext, 'FontSize', fsize);
set(handles.returner, 'FontSize', fsize);
set(handles.fontsizeup, 'FontSize', fsize);
set(handles.fontsizedown, 'FontSize', fsize);
set(handles.start, 'FontSize', fsize);
set(handles.options, 'FontSize', fsize);
set(handles.exit, 'FontSize', fsize);
set(handles.scorelabel, 'FontSize', fsize);
set(handles.score, 'FontSize', fsize);
set(handles.returner2, 'FontSize', fsize);
set(handles.testentry, 'FontSize', fsize);
set(handles.testquestion, 'FontSize', fsize);
set(handles.testInstructions, 'FontSize', fsize);
set(handles.checkbutton, 'FontSize', fsize);

% --- Executes on button press in fontsizedown.
function fontsizedown_Callback(hObject, eventdata, handles)
% hObject    handle to fontsizedown (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fsize;
if (fsize >= 10)
    fsize = fsize - 2;
end
set(handles.soundoption, 'FontSize', fsize);
set(handles.fstext, 'FontSize', fsize);
set(handles.returner, 'FontSize', fsize);
set(handles.fontsizeup, 'FontSize', fsize);
set(handles.fontsizedown, 'FontSize', fsize);
set(handles.start, 'FontSize', fsize);
set(handles.options, 'FontSize', fsize);
set(handles.exit, 'FontSize', fsize);
set(handles.scorelabel, 'FontSize', fsize);
set(handles.score, 'FontSize', fsize);
set(handles.returner2, 'FontSize', fsize);
set(handles.testentry, 'FontSize', fsize);
set(handles.testquestion, 'FontSize', fsize);
set(handles.testInstructions, 'FontSize', fsize);
set(handles.checkbutton, 'FontSize', fsize);

% --- Executes on button press in soundoption.
function soundoption_Callback(hObject, eventdata, handles)
% hObject    handle to soundoption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
state = get(handles.soundoption, 'String');
global soundState;
if (strcmp(state, 'Sound On'))
    set(handles.soundoption, 'String', 'Sound Off');
    soundState = false;
else
    set(handles.soundoption, 'String', 'Sound On');
    soundState = true;
end

% --- Executes on button press in returner.
function returner_Callback(hObject, eventdata, handles)
% hObject    handle to returner (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.mainmenu, 'visible', 'on');
set(handles.optionsmenu, 'visible', 'off');
set(handles.testPanel, 'visible', 'off');


% --- Executes on button press in selecttest.
function selecttest_Callback(hObject, eventdata, handles)
% hObject    handle to selecttest (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.mainmenu, 'visible', 'off');
set(handles.optionsmenu, 'visible', 'off'); % protective code
set(handles.testPanel, 'visible', 'on');


% --- Executes on button press in returner2.
function returner2_Callback(hObject, eventdata, handles)
% hObject    handle to returner2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.mainmenu, 'visible', 'on');
set(handles.optionsmenu, 'visible', 'off');
set(handles.testPanel, 'visible', 'off');

% TODO: Everything from here down

function testentry_Callback(hObject, eventdata, handles)
% hObject    handle to testentry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of testentry as text
%        str2double(get(hObject,'String')) returns contents of testentry as a double


% --- Executes during object creation, after setting all properties.
function testentry_CreateFcn(hObject, eventdata, handles)
% hObject    handle to testentry (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbutton.
function checkbutton_Callback(hObject, eventdata, handles)
% hObject    handle to checkbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
