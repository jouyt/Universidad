function zoompkrt(ga,cursor,callback)
%ZOOMPKRT Move cursor to next extrema on right.
%       ZOOMPKRT(H,CURSOR) where H is the axis ZOOMTOOL is
%       active in and CURSOR is the cursor number (1 or 2).
%
%       ZOOMPKRT(H,CURSOR,'CALLBACK') evaluates CALLBACK
%       string after a cursor movement.
%
%       Note: ZOOMPKRT is called after a ">>" push button event.
%
%       See also ZOOMCLR ZOOMDOWN ZOOMLEFT ZOOMMENU ZOOMMOVE
%       	ZOOMPKLF ZOOMPKRT ZOOMRGHT ZOOMSET ZOOMTGGL ZOOMTOOL
%       	ZOOMUP ZOOMXFUL ZOOMXIN ZOOMXOUT ZOOMYFUL ZOOMYIN
%       	ZOOMYOUT

%       Dennis W. Brown 1-10-94
%       Copyright (c) 1994 by Dennis W. Brown
%       May be freely distributed.
%       Not for use in commercial products.

% find parent window
gf = get(ga,'Parent');

% get some data about the current axes state
handles = get(finduitx(gf,'zoomtool'),'UserData');
xfactor = handles(28);
xmin = handles(33);
xmax = handles(34);
xxlim = get(ga,'Xlim');
xlim = (xxlim - xmin) / xfactor + 1;
kmax = (xmax-xmin+xfactor)/xfactor;

% get current cursor locations
if cursor == 1
	t = get(handles(24),'XData'); t = t(1);
else,
	t = get(handles(26),'XData'); t = t(1);
end;

% check to see if move will go past axis limits
if t >= xxlim(2)-100*eps,
	return;
end;

% index to right of current
k = (t - xmin) / xfactor + 2;

% new vertical cursor position
y = get(handles(39),'YData');
if k == kmax,
	k = xlim(2);
else,
	while (sign(y(k)-y(k+1)) ~= sign(y(k)-y(k-1)))
	    k = k+1;
	    if k >= xlim(2)-1, k = xlim(2); break; end;
	end;
end;

% new vertical cursor position
cv = (k-1) * xfactor + xmin;

% new horizontal cursor positon
ch = y(((cv - xmin) / xfactor) + 1);

% move cursor to mouse click location
handles = get(finduitx(gf,'zoomtool'),'UserData');     % handles to readouts
if cursor == 1,
	set(handles(24),'XData',[cv cv]);
	set(handles(25),'YData',[ch ch]);
	set(handles(18),'String',num2str(cv));
	set(handles(19),'String',num2str(ch));
	cvb = get(handles(26),'XData'); cvb = cvb(1);
	chb = get(handles(27),'YData'); chb = chb(1);
else
	set(handles(26),'XData',[cv cv]);
	set(handles(27),'YData',[ch ch]);
	set(handles(22),'String',num2str(cv));
	set(handles(23),'String',num2str(ch));
	cvb = get(handles(24),'XData'); cvb = cvb(1);
	chb = get(handles(25),'YData'); chb = chb(1);
end;

% adjust delta readouts
set(handles(20),'String',num2str(abs(cvb-cv)));
set(handles(21),'String',num2str(abs(chb-ch)));


% do callback
if nargin == 3,
	eval(callback);
end;
