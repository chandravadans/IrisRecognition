function varargout = gen_compare(varargin)
% GEN_COMPARE MATLAB code for gen_compare.fig
%      GEN_COMPARE, by itself, creates a new GEN_COMPARE or raises the existing
%      singleton*.
%
%      H = GEN_COMPARE returns the handle to a new GEN_COMPARE or the handle to
%      the existing singleton*.
%
%      GEN_COMPARE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GEN_COMPARE.M with the given input arguments.
%
%      GEN_COMPARE('Property','Value',...) creates a new GEN_COMPARE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gen_compare_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gen_compare_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gen_compare

% Last Modified by GUIDE v2.5 09-Mar-2012 11:20:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gen_compare_OpeningFcn, ...
                   'gui_OutputFcn',  @gen_compare_OutputFcn, ...
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


% --- Executes just before gen_compare is made visible.
function gen_compare_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gen_compare (see VARARGIN)

% Choose default command line output for gen_compare
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gen_compare wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gen_compare_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in image1.
function image1_Callback(hObject, eventdata, handles)
% hObject    handle to image1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.*','Choose an iris image');
fig=imread(strcat(pathname,filename));
setappdata(handles.figure1,'IrisImg1',fig);
subplot(3,1,1);imshow(fig);



% --- Executes on button press in image2.
function image2_Callback(hObject, eventdata, handles)
% hObject    handle to image2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname]=uigetfile('*.*','Choose an iris image');
fig=imread(strcat(pathname,filename));
setappdata(handles.figure1,'IrisImg2',fig);
subplot(3,1,2);imshow(fig);


% --- Executes on button press in template1.
function template1_Callback(hObject, eventdata, handles)
% hObject    handle to template1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=getappdata(handles.figure1,'IrisImg1');
[local xc yc time]=localisation2(eye,0.2);
[ci cp out time]=thresh(local,50,200);
[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
[temp th tv]=gen_templateVVV(parr);
setappdata(handles.figure1,'temp1',temp);
subplot(3,1,1);imshow(temp);



% --- Executes on button press in template2.
function template2_Callback(hObject, eventdata, handles)
% hObject    handle to template2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
eye=getappdata(handles.figure1,'IrisImg2');
[local xc yc time]=localisation2(eye,0.2);
[ci cp out time]=thresh(local,50,200);
[ring,parr]=normaliseiris(local,ci(2),ci(1),ci(3),cp(2),cp(1),cp(3),'normal.bmp',100,300);
[temp2 th tv]=gen_templateVVV(parr);
subplot(3,1,2);imshow(temp2);
temp1=getappdata(handles.figure1,'temp1');
hd=hammingdist(temp1, temp2);
set(handles.Result,'Visible','on');
set(handles.HammingVal,'Visible','on');
set(handles.HammingVal,'String',hd);
if(hd<=0.2)
    set(handles.HammingDist,'Visible','on');
    set(handles.Success,'Visible','on');
    set(handles.Fail,'Visible','off');

else
    set(handles.HammingDist,'Visible','on');
    set(handles.Fail,'Visible','on');
    set(handles.Success,'Visible','off');
end
    
