
function varargout = localisation(varargin)
% LOCALISATION MATLAB code for localisation.fig
%      LOCALISATION, by itself, creates a new LOCALISATION or raises the existing
%      singleton*.
%
%      H = LOCALISATION returns the handle to a new LOCALISATION or the handle to
%      the existing singleton*.
%
%      LOCALISATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LOCALISATION.M with the given input arguments.
%
%      LOCALISATION('Property','Value',...) creates a new LOCALISATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before localisation_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to localisation_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help localisation

% Last Modified by GUIDE v2.5 20-Dec-2011 19:24:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @localisation_OpeningFcn, ...
                   'gui_OutputFcn',  @localisation_OutputFcn, ...
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


% --- Executes just before localisation is made visible.
function localisation_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to localisation (see VARARGIN)

% Choose default command line output for localisation
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes localisation wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = localisation_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in LoadFile.
function LoadFile_Callback(hObject, eventdata, handles)
% hObject    handle to LoadFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.*','Choose an iris image');
fig=imread(strcat(pathname,filename));
setappdata(handles.figure1,'IrisImg',fig);
set(handles.LoadSuccess,'Visible','on');
subplot(4,1,1),imshow(fig);
set(handles.ReloadButton,'Visible','on');
set(handles.LoadFile,'Visible','off');
set(handles.reset,'Visible','on');





% --- Executes on button press in LocalisedImg.
function LocalisedImg_Callback(hObject, eventdata, handles)
% hObject    handle to LocalisedImg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig=getappdata(handles.figure1,'IrisImg');
[out xc yc time]=localisation2(fig,0.2);
subplot(4,1,2),imshow(out);
str=sprintf('Time taken= %.4f s',time);
set(handles.TimeTaken,'Visible','on');
set(handles.TimeTaken,'String',str);

% --- Executes on button press in directDaugman.
function directDaugman_Callback(hObject, eventdata, handles)
% hObject    handle to directDaugman (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=getappdata(handles.figure1,'IrisImg');
[ci cp out time]=thresh(eye,50,200);
%subplot(1,2,2),imshow(out);
subplot(4,1,3),imshow(out);
str=sprintf('Time taken= %.4f s',time);
set(handles.DaugTime,'String',str);
set(handles.DaugTime,'Visible','on');

% --- Executes on button press in Proposed.
function Proposed_Callback(hObject, eventdata, handles)
% hObject    handle to Proposed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=getappdata(handles.figure1,'IrisImg');
eye=localisation2(eye,0.2)
[ci cp out time]=thresh(eye,50,200);
subplot(4,1,4),imshow(out);
str=sprintf('Time taken= %.4f s',time);
set(handles.PropTime,'String',str);
set(handles.PropTime,'Visible','on');


% --- Executes on button press in ReloadButton.
function ReloadButton_Callback(hObject, eventdata, handles)
% hObject    handle to ReloadButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.*','Choose an iris image');
fig=imread(strcat(pathname,filename));
setappdata(handles.figure1,'IrisImg',fig);
set(handles.LoadSuccess,'Visible','on');
subplot(1,2,2),imshow(fig);
set(handles.LoadFile,'Visible','off');
set(handles.DaugTime,'Visible','off');
set(handles.PropTime,'Visible','off');
set(handles.ReloadButton,'Visible','on');


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig=getappdata(handles.figure1,'IrisImg');
subplot(1,2,2),imshow(fig);
set(handles.TimeTaken,'Visible','off');
