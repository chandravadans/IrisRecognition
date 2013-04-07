function varargout = iris_system(varargin)
% IRIS_SYSTEM MATLAB code for iris_system.fig
%      IRIS_SYSTEM, by itself, creates a new IRIS_SYSTEM or raises the existing
%      singleton*.
%
%      H = IRIS_SYSTEM returns the handle to a new IRIS_SYSTEM or the handle to
%      the existing singleton*.
%
%      IRIS_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IRIS_SYSTEM.M with the given input arguments.
%
%      IRIS_SYSTEM('Property','Value',...) creates a new IRIS_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iris_system_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iris_system_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iris_system

% Last Modified by GUIDE v2.5 09-Mar-2012 10:49:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iris_system_OpeningFcn, ...
                   'gui_OutputFcn',  @iris_system_OutputFcn, ...
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


% --- Executes just before iris_system is made visible.
function iris_system_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to iris_system (see VARARGIN)

% Choose default command line output for iris_system
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes iris_system wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = iris_system_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in loadimg.
function loadimg_Callback(hObject, eventdata, handles)
% hObject    handle to loadimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.*','Choose an image');
fig=imread(strcat(pathname,filename));
setappdata(handles.figure1,'IrisImg',fig);
subplot(1,2,2),imshow(fig);


% --- Executes on button press in localiseimg.
function localiseimg_Callback(hObject, eventdata, handles)
% hObject    handle to localiseimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fig=getappdata(handles.figure1,'IrisImg');
[local xc yc time]=localisation2(fig,0.2);
[ci cp out time]=thresh(local,50,200);
setappdata(handles.figure1,'localImg',local);
setappdata(handles.figure1,'IrisParam',ci);
setappdata(handles.figure1,'PupilParam',cp);
subplot(1,2,2),imshow(out);



% --- Executes on button press in normaliseimg.
function normaliseimg_Callback(hObject, eventdata, handles)
% hObject    handle to normaliseimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=getappdata(handles.figure1,'localImg');
ci=getappdata(handles.figure1,'IrisParam');
cp=getappdata(handles.figure1,'PupilParam');
[ring,parr]=normaliseiris(img,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
parr=adapthisteq(parr);
setappdata(handles.figure1,'normalImg',parr);
subplot(1,2,2);imshow(parr);


% --- Executes on button press in gen_template.
function gen_template_Callback(hObject, eventdata, handles)
% hObject    handle to gen_template (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
norm=getappdata(handles.figure1,'normalImg');
[temp th tv]=gen_templateVVV(norm);
subplot(1,2,2);imshow(temp);
