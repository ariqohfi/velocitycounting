function varargout = tubes3(varargin)
% TUBES3 MATLAB code for tubes3.fig
%      TUBES3, by itself, creates a new TUBES3 or raises the existing
%      singleton*.
%
%      H = TUBES3 returns the handle to a new TUBES3 or the handle to
%      the existing singleton*.
%
%      TUBES3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TUBES3.M with the given input arguments.
%
%      TUBES3('Property','Value',...) creates a new TUBES3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before tubes3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to tubes3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help tubes3

% Last Modified by GUIDE v2.5 06-Jun-2020 22:49:23

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @tubes3_OpeningFcn, ...
                   'gui_OutputFcn',  @tubes3_OutputFcn, ...
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


% --- Executes just before tubes3 is made visible.
function tubes3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to tubes3 (see VARARGIN)

% Choose default command line output for tubes3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes tubes3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% g = imread('jasamarga.jpg');
% axes(handles.axes1)
% imshow(g);

% --- Outputs from this function are returned to the command line.
function varargout = tubes3_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in openfile_start.
function openfile_start_Callback(hObject, eventdata, handles)
% hObject    handle to openfile_start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DATA = get(handles.uitable2,'data');
if isequal(DATA(1),cellstr(''))
    [nama_file,nama_path] = uigetfile({'*.txt'},'END');
    file = fopen(strcat(nama_path,nama_file));
    input = textscan(file,'%s %s');
    a = input{1};
    b = input{2};
    d = cellstr(num2str(zeros(size(b))));
else
    c = getappdata(0,'C');
    d = getappdata(0,'D');
    [nama_file,nama_path] = uigetfile({'.txt'},'END');
    file = fopen(strcat(nama_path,nama_file));
    input = textscan(file,'%s %s');
    a = input{1};
    b = input{2};
    [m,n]=size(b);
    for i=1:m
        if isequaln(a(i),c(i))
            for j=i:m
                if isequal(a(i),c(j))
                    b(i)=b(j)
                end
            end
        end
    end
end
set(handles.uitable2,'data',[a b d]);
setappdata(0,'A',a);
setappdata(0,'B',b);
   
% --- Executes on button press in openfile_end.
function openfile_end_Callback(hObject, eventdata, handles)
% hObject    handle to openfile_end (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DATA = get(handles.uitable2,'data');
if isequal(DATA(1),cellstr(''))
    [nama_file,nama_path] = uigetfile({'*.txt'},'END');
    file = fopen(strcat(nama_path,nama_file));
    input = textscan(file,'%s %s');
    c = input{1};
    d = input{2};
    b = cellstr(num2str(zeros(size(c))));
    a = c;
else
    a = getappdata(0,'A');
    b = getappdata(0,'B');
    [nama_file,nama_path] = uigetfile({'.txt'},'END');
    file = fopen(strcat(nama_path,nama_file));
    input = textscan(file,'%s %s');
    c = input{1};
    d = input{2};
    [m,n]=size(d);
    for i=1:m
        if isequaln(c(i),a(i))
            for j=i:m
                if isequal(c(i),a(j))
                    d(i)=d(j)
                end
            end
        end
    end
end
set(handles.uitable2,'data',[a b d]);
setappdata(0,'C',c);
setappdata(0,'D',d);

% --- Executes on button press in PB_Proses.
function PB_Proses_Callback(hObject, eventdata, handles)
% hObject    handle to PB_Proses (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
a = getappdata(0,'A');
b = getappdata(0,'B');
c = getappdata(0,'C');
d = getappdata(0,'D');
[m,n]=size(b);
set(handles.edit1,'String',m);
B = datetime(b,'InputFormat','HH:mm:ss');
D = datetime(d,'InputFormat','HH:mm:ss');
e = size(b);
E = zeros(e);
F = etime(datevec(B),datevec(D));
switch get(handles.miles,'Value')
    case 1
        set(handles.berguna,'String','Choose where do you want to go');
    case 2
        for i = 1:m
            E(i) = abs(150000/F(i));
        end
    case 3
        for i = 1:m
            E(i) = abs(187000/F(i));
        end
    case 4
        for i = 1:m
            E(i) = abs(210000/F(i)); 
        end
end
e = cellstr(num2str(E));
set(handles.uitable2,'data',[a b d e]);
setappdata(0,'E',e);

function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_exit.
function button_exit_Callback(hObject, eventdata, handles)
% hObject    handle to button_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pos_size = get(handles.figure1,'Position');

%Call modal dialog with the argument 'Position'.
user_response = dialogku('Title','Confirm Close');
switch user_response
    case 'No'
        %take no action
    case 'Yes'
        %Prepare to close application window
        delete(handles.figure1)
end
set(handles.edit1, 'String','');
set(handles.uitable2, 'Data', cell(size(get(handles.uitable2,'Data'))));
set(handles.berguna, 'String','');

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1, 'String','');
set(handles.uitable2, 'Data', cell(size(get(handles.uitable2,'Data'))));
set(handles.berguna, 'String','');

% --- Executes on selection change in miles.
function miles_Callback(hObject, eventdata, handles)
% hObject    handle to miles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns miles contents as cell array
%        contents{get(hObject,'Value')} returns selected item from miles


% --- Executes during object creation, after setting all properties.
function miles_CreateFcn(hObject, eventdata, handles)
% hObject    handle to miles (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function berguna_Callback(hObject, eventdata, handles)
% hObject    handle to berguna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of berguna as text
%        str2double(get(hObject,'String')) returns contents of berguna as a double


% --- Executes during object creation, after setting all properties.
function berguna_CreateFcn(hObject, eventdata, handles)
% hObject    handle to berguna (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
