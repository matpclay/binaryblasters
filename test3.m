function h = guigame
   h.fig = figure(1) ;
   h.txtDebug = uicontrol('Style','text','String','init') ;
   set(h.fig, 'KeyPressFcn', @processinput);
   guidata(h.fig,h)

function processinput(hobj,evt)
   h = guidata(hobj) ;
   a = get(h.fig,'CurrentKey');

   %// just to show that you captured the right key
   %// note the absence of console output
   set(h.txtDebug,'String',a)

   %// now do what you want with your captured key
   %// if a=='w' %move up..
   %// if a=='d' %move right..
   %// if a=='2' %switch to weapon 2..