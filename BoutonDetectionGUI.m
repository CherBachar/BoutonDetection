function varargout = BoutonDetectionGUI(varargin)
% GUI1 MATLAB code for gui1.fig
%      GUI1, by itself, creates a new GUI1 or raises the existing
%      singleton*.
%
%      H = GUI1 returns the handle to a new GUI1 or the handle to
%      the existing singleton*.
%
%      GUI1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI1.M with the given input arguments.
%
%      GUI1('Property','Value',...) creates a new GUI1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui1

% Last Modified by GUIDE v2.5 15-Dec-2016 17:35:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui1_OpeningFcn, ...
                   'gui_OutputFcn',  @gui1_OutputFcn, ...
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


% --- Executes just before gui1 is made visible.
function gui1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui1 (see VARARGIN)

% Choose default command line output for gui1
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in DetectBoutons.
function [finalBoutons, meanImage] = DetectBoutons_Callback(hObject, eventdata, handles)
% hObject    handle to DetectBoutons (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[finalBoutons, meanImage] = runBoutonDetection();
boutons = finalBoutons(1).Locations;
imagesc(meanImage{1});colormap(gray);
hold on;
plot(boutons(:,1),boutons(:,2),'g+')
display('done')





% --- Executes on button press in AddBouton.
function AddBouton_Callback(hObject, eventdata, handles)
% hObject    handle to AddBouton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

load('Data.mat');
load('currentImage.mat');
boutons = finalBoutons(n).Locations;
[xAdd,yAdd] = ginput;
locationsAdd = [xAdd,yAdd];
if ~isempty(locationsAdd)
    locationsAdd = addBoutons(locationsAdd, meanImage{1});
    boutons = [boutons; locationsAdd];
end
imagesc(meanImage{n});colormap(gray);
plot(boutons(:,1),boutons(:,2),'g+')
finalBoutons(n).Locations = boutons;
save('Data.mat', 'finalBoutons', 'meanImage') 



% --- Executes on button press in RemoveBouton.
function RemoveBouton_Callback(hObject, eventdata, handles)
% hObject    handle to RemoveBouton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('Data.mat');
load('currentImage.mat');
boutons = finalBoutons(n).Locations;
[xRemove,yRemove] = ginput;
if ~isempty(xRemove)
    boutons = removeBoutons(boutons, xRemove, yRemove);
end
imagesc(meanImage{n});colormap(gray);
plot(boutons(:,1),boutons(:,2),'g+')
finalBoutons(n).Locations = boutons;
save('Data.mat', 'finalBoutons', 'meanImage') 



function numImage_Callback(hObject, eventdata, handles)
% hObject    handle to numImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of numImage as text
%        str2double(get(hObject,'String')) returns contents of numImage as a double
n = str2double(get(hObject,'String'));
load('Data.mat');
boutons = finalBoutons(n).Locations;
imagesc(meanImage{n});colormap(gray);
plot(boutons(:,1),boutons(:,2),'g+')
save('currentImage.mat', 'n') 


% --- Executes during object creation, after setting all properties.
function numImage_CreateFcn(hObject, eventdata, handles)
% hObject    handle to numImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in contrast.
function contrast_Callback(hObject, eventdata, handles)
% hObject    handle to contrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imcontrast(gca);


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called