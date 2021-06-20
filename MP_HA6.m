function varargout = MP_HA6(varargin)
% UNTITLED MATLAB code for MP_HA6.fig
%      UNTITLED, by itself, creates a new UNTITLED or raises the existing
%      singleton*.
%   
%      H = UNTITLED returns the handle to a new UNTITLED or the handle to
%      the existing singleton*.
%
%      UNTITLED('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLED.M with the given input arguments.
%
%      UNTITLED('Property','Value',...) creates a new UNTITLED or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MP_HA6_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MP_HA6_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MP_HA6

% Last Modified by GUIDE v2.5 17-Apr-2021 12:30:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MP_HA6_OpeningFcn, ...
                   'gui_OutputFcn',  @MP_HA6_OutputFcn, ...
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


% --- Executes just before MP_HA6 is made visible.
function MP_HA6_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MP_HA6 (see VARARGIN)

% Choose default command line output for MP_HA6
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MP_HA6 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MP_HA6_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Upload_image.
function Upload_image_Callback(hObject, eventdata, handles)
% hObject    handle to Upload_image (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
global imback
global path
[path,cancel]=imgetfile();
if cancel
    msgbox(sprintf('Error'),'Error')
    return
end
im=imread(path);
imback=imread(path);
%im=im2double(im);
axes(handles.axes4)
imshow(im)


%convert image to grayscale
% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
%imgray=(im(:,:,1)+im(:,:,2)+im(:,:,3))/3; %not working correctly
im=0.2989*im(:,:,1)+0.5870*im(:,:,2)+0.1140*im(:,:,3);
axes(handles.axes4);
imshow(im);


% Convert image to negative
% --- Executes on button press in pushbutton2. 
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
axes(handles.axes4);
imshow(255-im);


% contrast stretching
% --- Executes on button press in Linear_stretching.
function Linear_stretching_Callback(hObject, eventdata, handles)
% hObject    handle to Linear_stretching (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 global im
 
 %axes(handles.axes4)
 %imshow(linearContrastStreching(im));

 a = str2double(get(handles.edit1,'String'));
 Ta = str2double(get(handles.edit2,'String'));
 b = str2double(get(handles.edit3,'String'));
 Tb = str2double(get(handles.edit4,'String'));


%newImg = im;
otra=im;

[rows, columns, depth]=size(im );


for R=1:rows
    for C=1:columns
        pixel=im(R,C);
        if pixel<=255 && pixel > b
            pixel=Tb + (((255-Tb)/(255-b))*(pixel-b));
        end
        if pixel<=b && pixel > a
            pixel=Ta +(((Tb-Ta)/(b-a))*(pixel-a));
        end
        if pixel<=a
            pixel=(Ta/a)*pixel;
        end
        otra(R,C)=pixel;
    end
end


axes(handles.axes4);
imshow(otra);

 
 x_range1 = 0:a;
 x_range2 = a:b;
 x_range3 = b:255;
 
 a1 = (Ta/a)*x_range1;
 a2 = Ta +(((Tb-Ta)/(b-a))*(x_range2-a));
 a3 = Tb + (((255-Tb)/(255-b)*(x_range3-b)));
 y = [a1 a2 a3];
% plot line
 axes(handles.axes6)
 plot(y);
 xlim([0 255]);
 ylim([0 255]);

% end

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



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Refresh.
function Refresh_Callback(hObject, eventdata, handles)
% hObject    handle to Refresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im
global path
im=imread(path);
axes(handles.axes4);
imshow(im);


% --- Executes on button press in histogram_equilization.
function histogram_equilization_Callback(hObject, eventdata, handles)
% hObject    handle to histogram_equilization (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im

numofpixels=size(im,1)*size(im,2);


HIm=uint8(zeros(size(im,1),size(im,2)));

freq=zeros(256,1);

probf=zeros(256,1);

probc=zeros(256,1);

cum=zeros(256,1);

output=zeros(256,1);


%freq counts the occurrence of each pixel value.

%The probability of each occurrence is calculated by probf.


for i=1:size(im,1)

    for j=1:size(im,2)

        value=im(i,j);

        freq(value+1)=freq(value+1)+1;

        probf(value+1)=freq(value+1)/numofpixels;

    end

end


sum=0;

no_bins=255;


%The cumulative distribution probability is calculated. 

for i=1:size(probf)

   sum=sum+freq(i);

   cum(i)=sum;

   probc(i)=cum(i)/numofpixels;

   output(i)=round(probc(i)*no_bins);

end

for i=1:size(im,1)

    for j=1:size(im,2)

            HIm(i,j)=output(im(i,j)+1);

    end

end

%rgbImage = ind2rgb(HIm, colormap);

axes(handles.axes4);
imshow(HIm);


% --- Executes on button press in Gaussian_stretching.
function Gaussian_stretching_Callback(hObject, eventdata, handles)
% hObject    handle to Gaussian_stretching (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global im

%I = imread('imagery.png');
%Filter the image with a Gaussian filter with standard deviation of 2.

Iblur = imgaussfilt(im,2);

axes(handles.axes4);
imshow(Iblur);
