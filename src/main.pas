unit main;

interface
{$ifdef gui3} {$define gui2} {$define net} {$define ipsec} {$endif}
{$ifdef gui2} {$define gui}  {$define jpeg} {$endif}
{$ifdef gui} {$define snd} {$endif}
{$ifdef con3} {$define con2} {$define net} {$define ipsec} {$endif}
{$ifdef con2} {$define jpeg} {$endif}
{$ifdef fpc} {$mode delphi}{$define laz} {$define d3laz} {$undef d3} {$else} {$define d3} {$define d3laz} {$undef laz} {$endif}
uses gossroot, {$ifdef gui}gossgui,{$endif} {$ifdef snd}gosssnd,{$endif} gosswin, gossio, gossimg, gossnet;
{$B-} {generate short-circuit boolean evaluation code -> stop evaluating logic as soon as value is known}
//## ==========================================================================================================================================================================================================================
//##
//## MIT License
//##
//## Copyright 2025 Blaiz Enterprises ( http://www.blaizenterprises.com )
//##
//## Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
//## files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
//## modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
//## is furnished to do so, subject to the following conditions:
//##
//## The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//##
//## THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//## OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//## LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//## CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//##
//## ==========================================================================================================================================================================================================================
//## Library.................. app code (main.pas)
//## Version.................. 1.00.655 (+5)
//## Items.................... -
//## Last Updated ............ 16jun2025, 28may2025, 24apr2025, 25mar2025, 05dec2024, 29nov2024, 24nov2024, 26apr2022
//## Lines of Code............ 1,600+
//##
//## main.pas ................ app code
//## gossroot.pas ............ console/gui app startup and control
//## gossio.pas .............. file io
//## gossimg.pas ............. image/graphics
//## gossnet.pas ............. network
//## gosswin.pas ............. 32bit windows api's/xbox controller
//## gosssnd.pas ............. sound/audio/midi/chimes
//## gossgui.pas ............. gui management/controls
//## gossdat.pas ............. app icons (24px and 20px) and help documents (gui only) in txt, bwd or bwp format
//## gosszip.pas ............. zip support
//## gossjpg.pas ............. jpeg support
//##
//## ==========================================================================================================================================================================================================================
//## | Name                   | Hierarchy         | Version   | Date        | Update history / brief description of function
//## |------------------------|-------------------|-----------|-------------|--------------------------------------------------------
//## | tapp                   | tbasicapp         | 1.00.650  | 16jun2025   | Create JPEG images with Quality - 28may2025, 05may2025, 24apr2025, 26mar2025: pastefit, 05dec2024, 24nov2024, 26apr2022
//## ==========================================================================================================================================================================================================================
//## Performance Note:
//##
//## The runtime compiler options "Range Checking" and "Overflow Checking", when enabled under Delphi 3
//## (Project > Options > Complier > Runtime Errors) slow down graphics calculations by about 50%,
//## causing ~2x more CPU to be consumed.  For optimal performance, these options should be disabled
//## when compiling.
//## ==========================================================================================================================================================================================================================


var
   itimerbusy:boolean=false;
   iapp:tobject=nil;

type
{tprogram}
//xxxxxxxxxxxxxxxxxxxxxxxxxxxxx//sssssssssssssssssssssssssssssssssss
   tapp=class(tbasicapp)
   private
    iscreen:tbasiccontrol;
    ibuffer,ibuffer2:tbasicimage;
    ioutdata:tstr8;
    istyle,iquality:tbasicsel;
    isize:tsimpleint;
    ioptions:tbasicset;
    ishiftrefY,ishiftrefX,idcolorcount,idw,idh,ilastfilterindex,iscreenstyleCount,iscreenstyle,ibufferid,imargin,idownx,idowny,iscreencolor:longint;
    imustbatchlist,icansave,ibatchJPG,ibatchJPEG,ibatchJIF,ibatchshowafter,ifit,imustpaint,ibuildingcontrol,iloaded:boolean;
    iinfotimer,ibuffertimer2,itimer100,itimer250,itimer500,itimerslow:comp;
    isizeref,ilastref,isyncref,isyncref2,ibufferref,ilowopenfilename,ilastfilename,ilastfilename2,iinforef,ilasterror,isettingsref:string;
    ibatchlist:tdynamicstring;
    procedure xcmd(sender:tobject;xcode:longint;xcode2:string);
    procedure __onclick(sender:tobject);
    procedure __ontimer(sender:tobject); override;
    procedure xloadsettings; override;
    procedure xsavesettings; override;
    procedure xautosavesettings;
    function xfindquality(xaslabel:boolean):string;
    function xref2:string;
    function xmustpaint2:boolean;
    function xmustbuffer2:boolean;
    procedure xbuffer2;
    procedure xsyncinfo;
    procedure xscreenpaint(sender:tobject);
    function xscreennotify(sender:tobject):boolean;
    procedure xfilter;
    function xempty:boolean;
    procedure xonshowmenuFill1(sender:tobject;xstyle:string;xmenudata:tstr8;var ximagealign:longint;var xmenuname:string);
    function xonshowmenuClick1(sender:tbasiccontrol;xstyle:string;xcode:longint;xcode2:string;xtepcolor:longint):boolean;
    function xscreencolor:longint;
    function xextJPGok(xfilename:string):boolean;
    function xcansave:boolean;
    function __onaccept(sender:tobject;xfolder,xfilename:string;xindex,xcount:longint):boolean;
    function xpreviewfilename(dext:string):string;
    procedure xpreview;
    function popsaveimgJPEG(var xfilename:string;xcommonfolder,xtitle2:string):boolean;//24nov2024: preveiew enabled, 18jun2021, 12apr2021
    function getsize:boolean;
    function getmirror:boolean;
    function getflip:boolean;
    function getgrey:boolean;
    function getsepia:boolean;
    function getnoise:boolean;
    function getinvert:boolean;
    function getsoften:boolean;
    procedure setsize(x:boolean);
    procedure setmirror(x:boolean);
    procedure setflip(x:boolean);
    procedure setgrey(x:boolean);
    procedure setsepia(x:boolean);
    procedure setnoise(x:boolean);
    procedure setinvert(x:boolean);
    procedure setsoften(x:boolean);
    function xshift:longint;
    function yshift:longint;
    //batch support
    procedure xbatchlist;
    function xbatchfolder:string;
    //.options
    function sizeBYTES:longint;
    property size:boolean read getsize write setsize;
    property mirror:boolean read getmirror write setmirror;
    property flip:boolean read getflip write setflip;
    property grey:boolean read getgrey write setgrey;
    property sepia:boolean read getsepia write setsepia;
    property noise:boolean read getnoise write setnoise;
    property invert:boolean read getinvert write setinvert;
    property soften:boolean read getsoften write setsoften;
   public
    //create
    constructor create; virtual;
    destructor destroy; override;
   end;

//info procs -------------------------------------------------------------------
function app__info(xname:string):string;
function info__app(xname:string):string;//information specific to this unit of code - 20jul2024: program defaults added, 23jun2024


//app procs --------------------------------------------------------------------
//.remove / create / destroy
procedure app__remove;//does not fire "app__create" or "app__destroy"
procedure app__create;
procedure app__destroy;

//.event handlers
function app__onmessage(m,w,l:longint):longint;
procedure app__onpaintOFF;//called when screen was live and visible but is now not live, and output is back to line by line
procedure app__onpaint(sw,sh:longint);
procedure app__ontimer;

//.support procs
function app__netmore:tnetmore;//optional - return a custom "tnetmore" object for a custom helper object for each network record -> once assigned to a network record, the object remains active and ".clear()" proc is used to reduce memory/clear state info when record is reset/reused
function app__findcustomtep(xindex:longint;var xdata:tlistptr):boolean;
function app__syncandsavesettings:boolean;

function mis__makejpeg(s,dout:tobject;ddatacopy:tstr8;ximageaction:string;xmirror,xflip,xgrey,xsepia,xnoise,xinvert,xsoften:boolean;xsizebytes:comp;var e:string):boolean;


implementation

{$ifdef gui}uses gossdat;{$endif}


//info procs -------------------------------------------------------------------
function app__info(xname:string):string;
begin
result:=info__rootfind(xname);
end;

function info__app(xname:string):string;//information specific to this unit of code - 20jul2024: program defaults added, 23jun2024
begin
//defaults
result:='';

try
//init
xname:=strlow(xname);

//get
if      (xname='slogan')              then result:=info__app('name')+' by Blaiz Enterprises'
else if (xname='width')               then result:='1300'
else if (xname='height')              then result:='900'
else if (xname='ver')                 then result:='1.00.655'
else if (xname='date')                then result:='16jun2025'
else if (xname='name')                then result:='Dougi'
else if (xname='web.name')            then result:='dougi'//used for website name
else if (xname='des')                 then result:='Create quality JPEG images with ease'
else if (xname='infoline')            then result:=info__app('name')+#32+info__app('des')+' v'+app__info('ver')+' (c) 1997-'+low__yearstr(2024)+' Blaiz Enterprises'
else if (xname='size')                then result:=low__b(io__filesize64(io__exename),true)
else if (xname='diskname')            then result:=io__extractfilename(io__exename)
else if (xname='service.name')        then result:=info__app('name')
else if (xname='service.displayname') then result:=info__app('service.name')
else if (xname='service.description') then result:=info__app('des')
else if (xname='new.instance')        then result:='1'//1=allow new instance, else=only one instance of app permitted
else if (xname='screensizelimit%')    then result:='95'//95% of screen area
else if (xname='realtimehelp')        then result:='0'//1=show realtime help, 0=don't
else if (xname='hint')                then result:='1'//1=show hints, 0=don't

//.links and values
else if (xname='linkname')            then result:=info__app('name')+' by Blaiz Enterprises.lnk'
else if (xname='linkname.vintage')    then result:=info__app('name')+' (Vintage) by Blaiz Enterprises.lnk'
//.author
else if (xname='author.shortname')    then result:='Blaiz'
else if (xname='author.name')         then result:='Blaiz Enterprises'
else if (xname='portal.name')         then result:='Blaiz Enterprises - Portal'
else if (xname='portal.tep')          then result:=intstr32(tepBE20)
//.software
else if (xname='software.tep')        then result:=intstr32(low__aorb(tepNext20,tepIcon20,sizeof(program_icon20h)>=2))
else if (xname='url.software')        then result:='https://www.blaizenterprises.com/'+info__app('web.name')+'.html'
else if (xname='url.software.zip')    then result:='https://www.blaizenterprises.com/'+info__app('web.name')+'.zip'
//.urls
else if (xname='url.portal')          then result:='https://www.blaizenterprises.com'
else if (xname='url.contact')         then result:='https://www.blaizenterprises.com/contact.html'
else if (xname='url.facebook')        then result:='https://web.facebook.com/blaizenterprises'
else if (xname='url.mastodon')        then result:='https://mastodon.social/@BlaizEnterprises'
else if (xname='url.twitter')         then result:='https://twitter.com/blaizenterprise'
else if (xname='url.x')               then result:=info__app('url.twitter')
else if (xname='url.instagram')       then result:='https://www.instagram.com/blaizenterprises'
else if (xname='url.sourceforge')     then result:='https://sourceforge.net/u/blaiz2023/profile/'
else if (xname='url.github')          then result:='https://github.com/blaiz2023'
//.program/splash
else if (xname='license')             then result:='MIT License'
else if (xname='copyright')           then result:='© 1997-'+low__yearstr(2025)+' Blaiz Enterprises'
else if (xname='splash.web')          then result:='Web Portal: '+app__info('url.portal')


//.program values -> defaults and fallback values
else if (xname='focused.opacity')     then result:='255'//range: 50..255
else if (xname='unfocused.opacity')   then result:='255'//range: 30..255
else if (xname='opacity.speed')       then result:='9'//range: 1..10 (1=slowest, 10=fastest)

else if (xname='head.center')         then result:='0'//1=center window title, 0=left align window title
else if (xname='head.align')          then result:='1'//0=left, 1=center, 2=right -> head based toolbar alignment
else if (xname='high.above')          then result:='0'//highlight above, 0=off, 1=on

else if (xname='modern')              then result:='1'//range: 0=legacy, 1=modern
else if (xname='scroll.size')         then result:='20'//scrollbar size: 5..72

else if (xname='bordersize')          then result:='7'//0..72 - frame size
else if (xname='sparkle')             then result:='7'//0..20 - default sparkle level -> set 1st time app is run, range: 0-20 where 0=off, 10=medium and 20=heavy)
else if (xname='brightness')          then result:='100'//60..130 - default brightness

else if (xname='ecomode')             then result:='0'//1=economy mode on, 0=economy mode off
else if (xname='emboss')              then result:='0'//0=off, 1=on
else if (xname='color.name')          then result:='black 8'//white 5'//default color scheme name
else if (xname='back.name')           then result:=''//default background name
else if (xname='frame.name')          then result:='narrow'//default frame name
else if (xname='frame.max')           then result:='1'//0=no frame when maximised, 1=frame when maximised
//.font
else if (xname='font.name')           then result:='Arial'//default GUI font name
else if (xname='font.size')           then result:='10'//default GUI font size
//.font2
else if (xname='font2.use')           then result:='1'//0=don't use, 1=use this font for text boxes (special cases)
else if (xname='font2.name')          then result:='Courier New'
else if (xname='font2.size')          then result:='12'
//.help
else if (xname='help.maxwidth')       then result:='500'//pixels - right column when help shown

//.paid/store support
else if (xname='paid')                then result:='0'//desktop paid status ->  programpaid -> 0=free, 1..N=paid - also works inconjunction with "system_storeapp" and it's cost value to determine PAID status is used within help etc
else if (xname='paid.store')          then result:='1'//store paid status
//.anti-tamper programcode checker - updated dual version (program EXE must be secured using "Blaiz Tools") - 11oct2022
else if (xname='check.mode')          then result:='-91234356'//disable check
//else if (xname='check.mode')          then result:='234897'//enable check
else
   begin
   //nil
   end;

except;end;
end;


//app procs --------------------------------------------------------------------
procedure app__create;
begin
{$ifdef gui}
iapp:=tapp.create;
{$else}

//.starting...
app__writeln('');
//app__writeln('Starting server...');

//.visible - true=live stats, false=standard console output
scn__setvisible(false);


{$endif}
end;

procedure app__remove;
begin
//reserved
end;

procedure app__destroy;
begin
try
//save
//.save app settings
app__syncandsavesettings;

//free the app
freeobj(@iapp);
except;end;
end;

function app__findcustomtep(xindex:longint;var xdata:tlistptr):boolean;

  procedure m(const x:array of byte);//map array to pointer record
  begin
  {$ifdef gui}
  xdata:=low__maplist(x);
  {$else}
  xdata.count:=0;
  xdata.bytes:=nil;
  {$endif}
  end;
begin//Provide the program with a set of optional custom "tep" images, supports images in the TEA format (binary text image)
//defaults
result:=false;

//sample custom image support

//m(tep_none);
{
case xindex of
5000:m(tep_write32);
5001:m(tep_search32);
end;
}

//successful
//result:=(xdata.count>=1);
end;

function app__syncandsavesettings:boolean;
begin
//defaults
result:=false;
try
//.settings
{
app__ivalset('powerlevel',ipowerlevel);
app__ivalset('ramlimit',iramlimit);
{}


//.save
app__savesettings;

//successful
result:=true;
except;end;
end;

function app__netmore:tnetmore;//optional - return a custom "tnetmore" object for a custom helper object for each network record -> once assigned to a network record, the object remains active and ".clear()" proc is used to reduce memory/clear state info when record is reset/reused
begin
result:=tnetbasic.create;
end;

function app__onmessage(m,w,l:longint):longint;
begin
//defaults
result:=0;
end;

procedure app__onpaintOFF;//called when screen was live and visible but is now not live, and output is back to line by line
begin
//nil
end;

procedure app__onpaint(sw,sh:longint);
begin
//console app only
end;

procedure app__ontimer;
begin
try
//check
if itimerbusy then exit else itimerbusy:=true;//prevent sync errors

//last timer - once only
if app__lasttimer then
   begin

   end;

//check
if not app__running then exit;


//first timer - once only
if app__firsttimer then
   begin

   end;



except;end;
try
itimerbusy:=false;
except;end;
end;

constructor tapp.create;
var
   p:longint;
   str1,e:string;
   xcurrent:tbasictoolbar;

   procedure xp(x:longint);
   begin
   if (xcurrent<>nil) and (x>=1) then xcurrent.csadd(intstr32(x)+'%',tepNone,0,'p.'+intstr32(x),'Scale image to '+intstr32(x)+'%',0);
   end;

   procedure xwh(xw,xh:longint);
   begin
   if (xw=0) then xw:=xh;
   if (xh=0) then xh:=xw;
   if (xcurrent<>nil) and (xw>=1) and (xh>=1) then xcurrent.csadd(intstr32(xw)+'x'+intstr32(xh),tepNone,0,'s:'+intstr32(xw)+'x'+intstr32(xh),'Set new size '+intstr32(xw)+'x'+intstr32(xh),0);
   end;
begin
if system_debug then dbstatus(38,'Debug 012');//yyyy

//self
inherited create(strint32(app__info('width')),strint32(app__info('height')),true);
ibuildingcontrol:=true;

//need checkers
need_jpeg;
need_gif;

//init sample disk
//idisk__init('Sample Images',[84,69,65,49,35,20,0,0,0,20,0,0,0,255,255,255,45,255,0,128,4,255,255,255,15,255,0,128,6,255,255,255,14,255,0,128,6,255,255,255,14,255,0,128,6,0,234,0,7,255,255,255,7,255,0,128,6,0,234,0,8,255,255,255,6,255,0,128,6,0,234,0,8,255,255,255,6,255,0,128,6,0,234,0,8,255,255,255,6,255,0,128,6,0,234,0,8,255,255,255,5,128,0,255,7,0,234,0,7,255,255,255,5,128,0,255,8,255,255,0,6,255,255,255,6,128,0,255,8,255,255,0,7,255,255,255,5,128,0,255,8,255,255,0,7,255,255,255,5,128,0,255,8,255,255,0,7,255,255,255,5,128,0,255,8,255,255,0,7,255,255,255,5,128,0,255,8,255,255,0,6,255,255,255,6,128,0,255,8,255,255,255,13,128,0,255,6,255,255,255,31]);
idisk__init('Sample Images',[0]);//

idisk__tofile21('Foliage.jpg',programfile_foliage_jpg,true,e);
idisk__tofile21('Bough.jpg',programfile_bough_jpg,true,e);
idisk__tofile21('Flower.jpg',programfile_flower_jpg,true,e);

//init
ifit:=true;
iinfotimer:=ms64;
itimer100:=ms64;
itimer250:=ms64;
itimer500:=ms64;
itimerslow:=ms64;
ibuffertimer2:=ms64;
xcurrent:=nil;

//vars
ilastref:='';
iloaded:=false;
iinforef:='';
ilasterror:='';
imustpaint:=false;
icansave:=false;
ishiftrefX:=0;
ishiftrefY:=0;
ibuffer   :=misimg24(1,1);
//was: mis__fromarray(ibuffer,programfile_toadstool_jpg,e);//sample image -> default on start - 18jun2021
//was: mis__fromarray(ibuffer,programfile_flower_jpg,e);//sample image -> default on start - 18jun2021
mis__fromarray(ibuffer,programfile_foliage_jpg,e);//sample image -> default on start - 18jun2021

if (misb(ibuffer)=32) then mask__setval(ibuffer,255);//was: missetAlphaval32(ibuffer,255,e);
ibuffer2  :=misimg24(1,1);//24bit only -> don't use 32bit for blending -> avoid problems - 09aug2021
ibufferid :=0;
ioutdata  :=str__new8;
isyncref  :='';
isyncref2 :='';
ibufferref:='';
imargin   :=32;
idw       :=0;
idh       :=0;
idownx    :=0;
idowny    :=0;
iscreenstyleCount:=8;
iscreenstyle:=0;
iscreencolor:=0;
ilowopenfilename:='';
//ilastfilename:='';
ilastfilename:='Foliage.jpg';
ilastfilename2:='';
ilastfilterindex:=0;
//.batch support
imustbatchlist:=false;
ibatchlist:=new__str;
ibatchshowafter:=false;
ibatchJPG:=false;
ibatchJPEG:=false;
ibatchJIF:=false;

//controls
with rootwin do
begin
ocanshowmenu:=true;
scroll:=false;
xhead;
xgrad;
xgrad2;

with xhead do
begin
add('Preview',tepScreen20,0,'preview','Image|Preview image in web browser');
add('Open',tepOpen20,0,'open','Image|Open image from file');
add('Save As',tepSaveAs20,0,'saveas','Image|Save image to file');
add('Save',tepSave20,0,'save','Image|Save image to file without prompting');
add('Menu',tepMenu20,0,'menu','Menu|Show menu');
add('Settings',tepSettings20,0,'settings','Settings|Show settings');
add('-',tepNone,0,'sep1','');
add('Copy',tepCopy20,0,'copy','Image|Copy image to Clipboard');
add('Paste',tepPaste20,0,'paste','Image|Paste image from Clipboard');
add('Paste Fit',tepPaste20,0,'pastefit','Image|Paste to fit image from Clipboard');
end;

//.screen
iscreen:=ncontrol;
iscreen.oautoheight:=true;
iscreen.oroundstyle:=corNone;//corToSquare;//corNone;
iscreen.bordersize:=0;
iscreen.help:='Quick Inspection|Drag image in any direction at 2x speed for full image inspection - automatic snap back to center upon release|*|Batch Image Conversion | Drag and drop two or more image files here for Batch Image Conversion';

//.quality
istyle:=xhigh2.xcolsh.cols2[0,30,false].nsel('Quality','Quality',0);
istyle.xadd('Manual','manual','Manual Quality | Manually adjust image quality');
istyle.xadd('Low',ia_lowquality,'Automatic Quality | Low image quality');
istyle.xadd('Fair',ia_fairquality,'Automatic Quality | Fair image quality');
istyle.xadd('Good',ia_goodquality,'Automatic Quality | Good image quality');
istyle.xadd('High',ia_highquality,'Automatic Quality | High image quality');
istyle.xadd('Best',ia_bestquality,'Automatic Quality | Best image quality');

//.options
ioptions:=xhigh2.xcolsh.cols2[1,45,false].nset('Options','Options',0,0);
with ioptions do
begin
xset(0,'Mirror',''   ,'Image Option| Mirror image (left-right)',true);
xset(1,'Flip',''     ,'Image Option| Flip image (top-bottom)',true);
xset(2,'Grey',''     ,'Image Option| Shades of grey',true);
xset(3,'Sepia',''    ,'Image Option| Sepia tones',true);
xset(4,'Noise',''    ,'Image Option| Noise texture',true);
xset(5,'Invert',''   ,'Image Option| Invert colors',true);
xset(6,'Soften',''   ,'Image Option| Soften edges',true);
xset(7,'Size',''     ,'Image Option| Enforce upper file size limit for JPEG image',true);
end;

//.size
isizeref:='';
isize:=xhigh2.xcolsh.cols2[2,25,false].mintb('Size','','Set the maximum file size for JPEG image',5,8000,1000,0);
isize.ounit:=' KB';

//.manual quality
iquality:=xhigh2.nsel('Manual Quality %','Manually adjust image quality - Higher quality generates a larger image size',0);
iquality.oflatback:=false;
for p:=1 to 20 do
begin
str1:=intstr32(p*5);
iquality.xadd(str1,ia__iadd('',ia_quality100,[p*5]),'Manual Quality | Set image quality to '+str1+'%');
end;//p
end;


//.last links on toolbar - 22mar2021
with rootwin.xhead do
begin
xaddoptions;
xaddhelp;
end;

with rootwin.xstatus2 do
begin
cellhelp[0]:='Image process status';
cellhelp[1]:='Output image dimensions';
cellhelp[2]:='Output JPEG image size';
cellhelp[3]:='Output JPEG image color count';

cellwidth[0]:=140;
cellwidth[1]:=200;
cellwidth[2]:=170;
cellwidth[3]:=250;
cellwidth[4]:=250;

end;


//events
rootwin.xhead.onclick:=__onclick;
//rootwin.xhigh2.xtoolbar.onclick:=__onclick;
iscreen.onpaint:=xscreenpaint;
iscreen.onnotify:=xscreennotify;
rootwin.showmenuFill1:=xonshowmenuFill1;
rootwin.showmenuClick1:=xonshowmenuClick1;
//was: iscreen.onaccept:=__onaccept;//drag and drop support
rootwin.onaccept:=__onaccept;//drag and drop support

//defaults
xsyncinfo;

//start timer event
ibuildingcontrol:=false;
xloadsettings;

//.low__paramstr1
str1:=low__paramstr1;
if (str1<>'') then __onaccept(self,'',str1,0,0);
//.mark not modified - 04sep2021
xbuffer2;

//finish
createfinish;
end;

destructor tapp.destroy;
begin
try
//settings
xautosavesettings;

//controls
freeobj(@ibuffer);
freeobj(@ibuffer2);
freeobj(@ioutdata);
freeobj(@ibatchlist);

//cleanup
io__remfile(xpreviewfilename('html'));
io__remfile(xpreviewfilename('jpg'));

//self
inherited destroy;
except;end;
end;

function tapp.__onaccept(sender:tobject;xfolder,xfilename:string;xindex,xcount:longint):boolean;
begin
result:=true;

try
if (xcount<=0) then exit
else if (xcount=1) then
   begin
   if (xindex=0) and io__fileexists(xfilename) then
      begin
      //open filename if only 1 filename has been droppped on GUI
      ilowopenfilename:=xfilename;
      xcmd(self,100,'lowopen');
      end;
   end
else
   begin
   //add to batch list if 2+ filenames have been dropped onto GUI
   ibatchlist.value[ibatchlist.count]:=xfilename;
   if (xindex>=(xcount-1)) then imustbatchlist:=true;
   end;
except;end;
end;

function tapp.popsaveimgJPEG(var xfilename:string;xcommonfolder,xtitle2:string):boolean;//24nov2024: preveiew enabled, 18jun2021, 12apr2021
var
   xfilterindex:longint;
   daction,xfilterlist:string;
begin
result:=false;

try
//filterlist
xfilterindex:=0;
xfilterlist:={$ifdef jpeg}pejpg+pejif+pejpeg+{$endif}'';
need_jpeg;
//get
daction:='';
result:=gui.xpopnav3(xfilename,xfilterindex,xfilterlist,strdefb(xcommonfolder,low__platfolder('images')),'save','','Save Image'+xtitle2,daction,true);
except;end;
end;

function tapp.xpreviewfilename(dext:string):string;
begin
result:=low__platfolder('temp')+io__ownname+insstr('.',dext<>'')+dext;
end;

procedure tapp.xpreview;
label
   skipend;
const
   hsep=' &nbsp; ';
var
   b:tstr8;
   xjpg,e:string;
   xok:boolean;

   procedure xadd(x:string);
   begin
   b.sadd(x+rcode);
   end;
begin
//defaults
xok:=false;
e:=gecTaskfailed;
b:=nil;

try
//init
b:=str__new8;
xjpg:=xpreviewfilename('jpg');

//write html
b.clear;
xadd('<!DOCTYPE html>');
xadd('<html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml">');
xadd('<head>');
xadd('<meta name="generator" content="'+programname+' v'+programversion+' by BlaizEnterprises.com (c) 1997-'+low__yearstr(2022)+' All Rights Reserved"/>');
xadd('</head>');
xadd('<body>');
xadd('<div style="display:block;font-size:2em;background-color:white;opacity:0.5;">Preview of JPEG image</div>');
xadd('<div style="display:block;"><a href="'+io__extractfilename(xjpg)+'" title="Click to view at 1:1"><img style="max-width:100%;" src="'+io__extractfilename(xjpg)+'" border=0></a></div>');
xadd('<div style="display:block;font-size:1em;background-color:white;opacity:0.5;">Quality: '+xfindquality(true)+hsep+'Size: '+low__mbAUTO2(ioutdata.len,2,true)+hsep+'Colors: '+k64(idcolorcount)+'</div>');
xadd('</body>');
xadd('</html>');
if not io__tofile(xpreviewfilename('html'),@b,e) then goto skipend;
//write jpg
if not io__tofile(xjpg,@ioutdata,e) then goto skipend;
//view html
runLOW(xpreviewfilename('html'),'');
//successful
xok:=true;
skipend:
except;end;
try
str__free(@b);
if not xok then gui.poperror('',e);
except;end;
end;

function tapp.xextJPGok(xfilename:string):boolean;
var
   v:string;
begin
v:=strlow(io__readfileext(xfilename,false));
result:=(v='jpg') or (v='jpeg') or (v='jif');
end;

function tapp.xcansave:boolean;
begin
result:=(ilastfilename<>'') and (not xempty) and icansave and xextJPGok(ilastfilename);
end;

procedure tapp.xloadsettings;
var
   a:tvars8;
begin
try
//defaults
a:=nil;
//check
if zznil(prgsettings,5001) then exit;
//init
a:=vnew2(950);
//filter
a.b['show.save']:=prgsettings.bdef('show.save',false);
a.i['screenstyle']:=prgsettings.idef('screenstyle',0);
a.i['screencolor']:=prgsettings.idef('screencolor',rgba0__int(60,60,60));
a.i['quality']:=prgsettings.idef('quality',9);//manual quality: 50%
a.i['style']:=prgsettings.idef('style',3);//quality: good
a.i['options']:=prgsettings.idef('options',0);
a.i['size']:=prgsettings.idef('size',1000);
a.b['fit']:=prgsettings.bdef('fit',true);

a.b['batch.showafter']:=prgsettings.bdef('batch.showafter',true);
a.b['batch.jpg'] :=prgsettings.bdef('batch.jpg',true);
a.b['batch.jpeg']:=prgsettings.bdef('batch.jpeg',false);
a.b['batch.jif'] :=prgsettings.bdef('batch.jif',false);

//get
//.main toolbar
with rootwin.xhead do
begin
bvisible2['save']:=a.b['show.save'];
end;

//.other
iscreenstyle:=frcrange32(a.i['screenstyle'],0,iscreenstyleCount-1);
iscreencolor:=a.i['screencolor'];
iquality.val:=a.i['quality'];
istyle.val:=a.i['style'];
ioptions.val:=a.i['options'];
isize.val:=a.i['size'];
ifit:=a.b['fit'];

ibatchshowafter:=a.b['batch.showafter'];
ibatchJPG :=a.b['batch.jpg'];
ibatchJPEG:=a.b['batch.jpeg'];
ibatchJIF :=a.b['batch.jif'];

//sync
prgsettings.data:=a.data;
except;end;
try
freeobj(@a);
iloaded:=true;
except;end;
end;

procedure tapp.xsavesettings;
var
   a:tvars8;
begin
try
//check
if not iloaded then exit;

//defaults
a:=nil;
a:=vnew2(951);

//get
//.main toolbar
a.b['show.save']      :=rootwin.xhead.bvisible2['save'];
//.other
a.i['screenstyle']    :=frcrange32(iscreenstyle,0,iscreenstyleCount-1);
a.i['screencolor']    :=iscreencolor;
a.i['quality']        :=iquality.val;
a.i['style']          :=istyle.val;
a.i['options']        :=ioptions.val;
a.i['size']           :=isize.val;
a.b['fit']            :=ifit;

a.b['batch.showafter']:=ibatchshowafter;
a.b['batch.jpg']      :=ibatchJPG;
a.b['batch.jpeg']     :=ibatchJPEG;
a.b['batch.jif']      :=ibatchJIF;

//set
prgsettings.data:=a.data;
siSaveprgsettings;
except;end;
try;freeobj(@a);except;end;
end;

function tapp.xscreencolor:longint;
begin
case iscreenstyle of
0:result:=vinormal.background;//window (default)
1:result:=rgba0__int(40,40,40);
2:result:=rgba0__int(60,60,60);
3:result:=rgba0__int(120,120,120);
4:result:=rgba0__int(0,0,0);
5:result:=rgba0__int(255,255,255);
6:result:=rgba0__int(240,240,240);
else result:=iscreencolor;
end;
end;

procedure tapp.xautosavesettings;
var
   str1:string;
begin
try
//check
if not iloaded then exit;
//get
str1:=rootwin.xhead.visref+'|'+intstr32(iscreenstyle)+'|'+intstr32(xscreencolor)+'|'+intstr32(istyle.val)+'|'+intstr32(iquality.val)+'|'+bnc(ibatchJPG)+bnc(ibatchJPEG)+bnc(ibatchJIF)+bnc(ibatchshowafter)+bnc(ifit)+'|'+intstr32(ioptions.val)+'|'+intstr32(isize.val);
if low__setstr(isettingsref,str1) then xsavesettings;
except;end;
end;

function tapp.xref2:string;
begin
result:=intstr32(misw(ibuffer))+'|'+intstr32(mish(ibuffer))+'|'+intstr32(istyle.val)+'|'+intstr32(iquality.val)+'|'+intstr32(ioptions.val)+'|'+intstr32(sizeBYTES);
end;

function tapp.xmustpaint2:boolean;
begin
result:=low__setstr(isyncref2,bolstr(ifit));
end;

function tapp.xmustbuffer2:boolean;
begin
result:=low__setstr(isyncref,xref2);
end;

function tapp.xfindquality(xaslabel:boolean):string;
var
   v:longint;
begin
if (istyle.val=0) then
   begin
   v:=(iquality.val+1)*5;//5..100
   if xaslabel then result:=k64(v)+'%' else result:=iquality.nams[iquality.val];
   end
else
   begin
   if xaslabel then result:=istyle.caps[istyle.val] else result:=istyle.nams[istyle.val];
   end;
end;

procedure tapp.xbuffer2;
var
   e:string;
begin
try
//reset - do FIRST to catch any LATE option changes -> trigger a redover - 04may2022
xmustbuffer2;

//get
iscreen.xfaster;
rootwin.xstatus2.cellpert[0]:=50;//26apr2022
rootwin.xstatus2.celltext[0]:='Working...';
rootwin.xstatus2.paintimmediate;

mis__makejpeg(ibuffer,ibuffer2,ioutdata,xfindquality(false),mirror,flip,grey,sepia,noise,invert,soften,sizeBYTES,e);

idw:=misw(ibuffer2);
idh:=mish(ibuffer2);
rootwin.xstatus2.cellpert[0]:=90;//26apr2022
rootwin.xstatus2.paintimmediate;
idcolorcount:=miscountcolors(ibuffer2);

//set
rootwin.xstatus2.cellpert[0]:=100;//26apr2022
rootwin.xstatus2.paintimmediate;

//was: xmustbuffer2;
low__iroll(ibufferid,1);
xmustpaint2;
imustpaint:=true;
except;end;
try
rootwin.xstatus2.cellpert[0]:=0;//26apr2022
rootwin.xstatus2.celltext[0]:='Ready';
rootwin.xstatus2.paintnow;
except;end;
end;

procedure tapp.__onclick(sender:tobject);
begin
xcmd(sender,0,'');
end;

procedure tapp.xcmd(sender:tobject;xcode:longint;xcode2:string);
label
   skipend;
var
   a:tbasicimage;
   b:tstr8;
   bol1,xresult,zok:boolean;
   e:string;
begin
//defaults
xresult:=false;
e:=gecTaskfailed;
a:=nil;
b:=nil;

try
//init
zok:=zzok(sender,7455);
if zok and (sender is tbasictoolbar) then
   begin
   //ours next
   xcode:=(sender as tbasictoolbar).ocode;
   xcode2:=strlow((sender as tbasictoolbar).ocode2);
   end;
//get
if (xcode2='menu') then rootwin.showmenu2('menu')
else if (xcode2='settings') then rootwin.showmenu2('settings')
else if (xcode2='lowopen') then
   begin
   b:=str__new8;
   if not io__fromfile(ilowopenfilename,@b,e) then goto skipend;
   ilastfilename:=ilowopenfilename;
   if mis__fromdata(ibuffer,@b,e) then misonecell(ibuffer)//one cell - 26par2022
   else
      begin
      missize(ibuffer,1,1);
      xbuffer2;
      goto skipend;
      end;
   xbuffer2;
   icansave:=true;
   end
else if (xcode2='preview') then xpreview
else if (xcode2='open') then
   begin
   if gui.popopenimg(ilastfilename,ilastfilterindex,'') then
      begin
      b:=str__new8;
      if not io__fromfile(ilastfilename,@b,e) then goto skipend;
      if mis__fromdata(ibuffer,@b,e) then misonecell(ibuffer)//one cell - 26par2022
      else
         begin
         missize(ibuffer,1,1);
         xbuffer2;
         goto skipend;
         end;
      xbuffer2;
      icansave:=true;
      end;
   end
else if (xcode2='save') then
   begin
   if xcansave then
      begin
      if not io__tofile(ilastfilename,@ioutdata,e) then goto skipend;
      end;
   end
else if (xcode2='saveas') then
   begin
   if not xempty then
      begin
      if popsaveimgJPEG(ilastfilename,'','') then
         begin
         if not io__tofile(ilastfilename,@ioutdata,e) then goto skipend;
         icansave:=true;
         end;
      end;
   end
else if (xcode2='saveas2') then
   begin
   if not xempty then
      begin
      if popsaveimgJPEG(ilastfilename2,'',' (Copy)') then//18jun2021
         begin
         if not io__tofile(ilastfilename2,@ioutdata,e) then goto skipend;
         end;
      end;
   end
else if (xcode2='copy') then
   begin
   if (not xempty) and (not clip__copyimage(ibuffer2)) then goto skipend;
   end
else if (xcode2='paste') then
   begin
   bol1:=clip__pasteimage(ibuffer);
   if bol1 then xbuffer2 else goto skipend;
   end
else if (xcode2='pastefit') then//26mar2025
   begin
   a:=misimg32(1,1);
   bol1:=clip__pasteimage(a);
   if bol1 then
      begin
      miscopyarea32(0,0,misw(ibuffer),mish(ibuffer),misarea(a),ibuffer,a);
      xbuffer2;
      end
   else goto skipend;
   end
else if (strcopy1(xcode2,1,12)='screenstyle.') then
   begin
   iscreenstyle:=frcrange32(strint(strcopy1(xcode2,13,length(xcode2))),0,iscreenstyleCount-1);
   if (iscreenstyle=(iscreenstylecount-1)) then gui.popcolor(iscreencolor);
   end
//.main toolbar
else if (xcode2='show.save')        then rootwin.xhead.bvisible2['save']:=not rootwin.xhead.bvisible2['save']
else if (xcode2='fit')              then ifit:=not ifit//03sep2021
else if (xcode2='batch.showafter')  then ibatchshowafter:=not ibatchshowafter//24nov2024
else if (xcode2='batch.showfolder') then runlow(xbatchfolder,'')//24nov2024
else if (xcode2='batch.jpg')        then ibatchJPG:=not ibatchJPG//24nov2024
else if (xcode2='batch.jpeg')       then ibatchJPEG:=not ibatchJPEG//24nov2024
else if (xcode2='batch.jif')        then ibatchJIF:=not ibatchJIF//24nov2024
else
   begin
   if system_debug then showbasic('Unknown Command>'+xcode2+'<<');
   end;

//successful
xresult:=true;
skipend:
except;end;
try
freeobj(@a);
str__free(@b);
except;end;
try
xfilter;
xsyncinfo;
if not xresult then gui.poperror('',e);
except;end;
end;

procedure tapp.__ontimer(sender:tobject);//._ontimer
label
   skipend;
var
   bol1,bol2,xmustpaint:boolean;
begin
try
//init
xmustpaint:=false;


//timer100
if (ms64>=itimer100) and iloaded then
   begin
   //filter
   xfilter;

   //reset
   itimer100:=ms64+100;
   end;


//shift
bol1:=low__setint(ishiftrefX,xshift);
bol2:=low__setint(ishiftrefY,yshift);
if bol1 or bol2 then
   begin
   app__turbo;
   xmustpaint:=true;
   end;


//buffertimer2
if (ms64>=ibuffertimer2) and iloaded then
   begin
   if low__setstr(isizeref,intstr32(sizebytes)) then ibuffertimer2:=ms64+1000
   else
      begin
      if (not gui.mousedown) and xmustbuffer2 then xbuffer2
      else if xmustpaint2                     then imustpaint:=true;

      ibuffertimer2:=ms64+100;
      end;
   end;


//iinfotimer
if (ms64>=iinfotimer) then
   begin
   xsyncinfo;
   //reset
   iinfotimer:=ms64+500;
   end;

//timer500
if (ms64>=itimer500) and iloaded then
   begin
   //savesettings
   xautosavesettings;
   //info
   if low__setstr(iinforef,ilastfilename) then xsyncinfo;
   //bath support
   if imustbatchlist then
      begin
      imustbatchlist:=false;
      xbatchlist;
      end;
   //reset
   itimer500:=ms64+500;
   end;

//timerslow
if (ms64>=itimerslow) then
   begin

   //reset
   itimerslow:=ms64+2000;
   end;

//mustpaint
if xmustpaint or imustpaint then
   begin
   imustpaint:=false;
   iscreen.paintnow;
   end;

//debug support
if system_debug then
   begin
   if system_debugFAST then rootwin.paintallnow;
   end;
if system_debug and system_debugRESIZE then
   begin
   if (system_debugwidth<=0) then system_debugwidth:=gui.width;
   if (system_debugheight<=0) then system_debugheight:=gui.height;
   //change the width and height to stress
   //was: if (random(10)=0) then gui.setbounds(gui.left,gui.top,system_debugwidth+random(32)-16,system_debugheight+random(128)-64);
   gui.setbounds(gui.left,gui.top,system_debugwidth+random(32)-16,system_debugheight+random(128)-64);
   end;

skipend:
except;end;
end;

function tapp.xbatchfolder:string;
begin
result:=app__subfolder('batch');
end;

function tapp.sizeBYTES:longint;
begin
if size then result:=(isize.val*1000) else result:=0;
end;

function tapp.getsize:boolean;
begin
result:=ioptions.vals[7];
end;

procedure tapp.setsize(x:boolean);
begin
ioptions.vals[7]:=x;
end;

function tapp.getmirror:boolean;
begin
result:=ioptions.vals[0];
end;

procedure tapp.setmirror(x:boolean);
begin
ioptions.vals[0]:=x;
end;

function tapp.getflip:boolean;
begin
result:=ioptions.vals[1];
end;

procedure tapp.setflip(x:boolean);
begin
ioptions.vals[1]:=x;
end;

function tapp.getgrey:boolean;
begin
result:=ioptions.vals[2];
end;

procedure tapp.setgrey(x:boolean);
begin
ioptions.vals[2]:=x;
end;

function tapp.getsepia:boolean;
begin
result:=ioptions.vals[3];
end;

procedure tapp.setsepia(x:boolean);
begin
ioptions.vals[3]:=x;
end;

function tapp.getnoise:boolean;
begin
result:=ioptions.vals[4];
end;

procedure tapp.setnoise(x:boolean);
begin
ioptions.vals[4]:=x;
end;

function tapp.getinvert:boolean;
begin
result:=ioptions.vals[5];
end;

procedure tapp.setinvert(x:boolean);
begin
ioptions.vals[5]:=x;
end;

function tapp.getsoften:boolean;
begin
result:=ioptions.vals[6];
end;

procedure tapp.setsoften(x:boolean);
begin
ioptions.vals[6]:=x;
end;

procedure tapp.xbatchlist;
var
   s,d:tbasicimage;
   ddata:tstr8;
   xsizebytes,xoutbytes,xoutgood,xouterror,xtimeref,xref:comp;
   xcount,p:longint;
   dformat,ximageaction,dfolder,dfilename,xfilename,e:string;
   xok,djpg,djpeg,djif,xstopped,xmirror,xflip,xgrey,xsepia,xnoise,xinvert,xsoften:boolean;

   procedure xinc(xgood:boolean);
   begin
   if xgood then
      begin
      xoutgood:=add64(xoutgood,1);
      xoutbytes:=add64(xoutbytes,str__len(@ddata));
      end
   else xouterror:=add64(xouterror,1);
   end;
begin
//defaults
s:=nil;
d:=nil;
ddata:=nil;
xstopped:=false;
xoutbytes:=0;
xoutgood:=0;
xouterror:=0;

try
//check
if (ibatchlist.count<=0) then exit;//nothing to do

//init
xtimeref:=ms64;
xcount:=ibatchlist.count;
s:=misimg32(1,1);
d:=misimg32(1,1);
ddata:=str__new8;
dfolder:=xbatchfolder;

djpg :=ibatchJPG or ((not ibatchJPG) and (not ibatchJPEG) and (not ibatchJIF));
djpeg:=ibatchJPEG;
djif :=ibatchJIF;
dformat:='';
if djpg  then dformat:=dformat+insstr(' + ',dformat<>'')+'JPG';
if djpeg then dformat:=dformat+insstr(' + ',dformat<>'')+'JPEG';
if djif  then dformat:=dformat+insstr(' + ',dformat<>'')+'JIF';

ximageaction:=xfindquality(false);
xmirror     :=mirror;
xflip       :=flip;
xgrey       :=grey;
xsepia      :=sepia;
xnoise      :=noise;
xinvert     :=invert;
xsoften     :=soften;
xsizebytes  :=sizeBYTES;

//init status handler
gui.xstatusstart(6);
gui.xstatustab(tbDefault);

sysstatus_settext(0,'Image'+#9+'');
sysstatus_settext(1,'Format'+#9+dformat);
sysstatus_settext(2,'Size'+#9+'');
sysstatus_settext(3,'Total'+#9+'');
sysstatus_settext(4,'Errors'+#9+'');
sysstatus_settext(5,'Time'+#9+'');
gui.xstatus(0,'Batch Image Conversion');
msset(xref,100);

//get
for p:=0 to (xcount-1) do
begin
xfilename:=ibatchlist.value[p];
dfilename:=dfolder+io__remlastext(io__extractfilename(xfilename));//no extension at this point

//.status
if (p=0) or msok(xref) then
   begin
   sysstatus_settext(0,'Image'+#9+io__extractfilename(xfilename));
   sysstatus_settext(2,'Size'+#9+low__mbAUTO(xoutbytes,true));
   sysstatus_settext(3,'Files'+#9+k64(xoutgood));
   sysstatus_settext(4,'Errors'+#9+k64(xouterror));
   sysstatus_settext(5,'Time'+#9+low__uptime(sub64(ms64,xtimeref),false,false,true,true,false,#32));
   sysstatus_setpert(low__percentage64(p+1,xcount));
   msset(xref,100);
   end;

//.load -> convert -> save
xok:=mis__fromfile(s,xfilename,e) and mis__makejpeg(s,d,ddata,ximageaction,xmirror,xflip,xgrey,xsepia,xnoise,xinvert,xsoften,xsizebytes,e);

if djpg  then xinc(xok and io__tofile64(dfilename+'.jpg' ,@ddata,e));
if djpeg then xinc(xok and io__tofile64(dfilename+'.jpeg',@ddata,e));
if djif  then xinc(xok and io__tofile64(dfilename+'.jif' ,@ddata,e));

//.user stopped batch processing
if gui.xstatustopped then
   begin
   xstopped:=true;
   break;
   end;
end;//p

except;end;
try
gui.xstatusstop;
ibatchlist.clear;
freeobj(@s);
freeobj(@d);
str__free(@ddata);
if (xoutgood>=1) and ibatchshowafter and (not xstopped) then runlow(xbatchfolder,'');
except;end;
end;

procedure tapp.xsyncinfo;
var
   bol1,acanpaste,aempty:boolean;
begin
try
//init
aempty:=xempty;
//mustcloseprompt - 26aug2021
//was: gui.mustcloseprompt:=imodified;
//status
rootwin.xhead.caption2:=insstr(' - '+io__extractfilename(ilastfilename),ilastfilename<>'');
rootwin.xstatus2.celltext[1]:='Size '+k64(misw(ibuffer))+'w x '+k64(mish(ibuffer))+'h';
rootwin.xstatus2.celltext[2]:='JPEG '+low__mbAUTO2(ioutdata.len,2,true);
rootwin.xstatus2.celltext[3]:=k64(idcolorcount)+' color'+insstr('s',idcolorcount<>1);

//main toolbar
acanpaste:=clip__canpasteimage;
rootwin.xhead.benabled2['preview']:=not aempty;//03sep2021
rootwin.xhead.benabled2['save']:=xcansave;
rootwin.xhead.benabled2['saveas']:=not aempty;
rootwin.xhead.benabled2['copy']:=not aempty;
rootwin.xhead.benabled2['paste']:=acanpaste;
rootwin.xhead.benabled2['pastefit']:=acanpaste;
rootwin.xhead.bvisible2['sep1']:=rootwin.xhead.bvisible2['copy'] or rootwin.xhead.bvisible2['paste'] or rootwin.xhead.bvisible2['pastefit'];
rootwin.xhead.bvisible2['sep2']:=rootwin.xhead.bvisible2['copy'] or rootwin.xhead.bvisible2['paste'] or rootwin.xhead.bvisible2['pastefit'];

rootwin.xhigh2.xcolsh.vis[2]:=size;

//bottom boolbar
bol1:=(istyle.val=0);
if (bol1<>iquality.visible) then
   begin
   iquality.visible:=bol1;
   gui.fullalignpaint;
   end;
except;end;
end;

function tapp.xshift:longint;
begin
if gui.mousedown and iscreen.focused then result:=(gui.mousemovexy.x-gui.mousedownxy.x)*2 else result:=0;
end;

function tapp.yshift:longint;
begin
if gui.mousedown and iscreen.focused then result:=(gui.mousemovexy.y-gui.mousedownxy.y)*2 else result:=0;
end;

procedure tapp.xscreenpaint(sender:tobject);
label
   skipend;
var
   dcolor,dx,dy,dw,dh,ddw,ddh,cw,ch:longint;
   xround,xshowalpha:boolean;
begin
try
//init
xround:=false;
xshowalpha:=false;
cw:=iscreen.clientwidth;
ch:=iscreen.clientheight;
dw:=idw;
dh:=idh;
ddw:=dw;
ddh:=dh;
if ifit then low__scaledown(cw,ch,dw,dh,ddw,ddh);//scale down to fit screen - 03spe2021
dcolor:=xscreencolor;
if xempty then
   begin
   dw:=0;
   dh:=0;
   end;
dx:=((cw-ddw) div 2) + xshift;
dy:=((ch-ddh) div 2) + yshift;



//cls
//iscreen.lds(da,dcolor,false);
iscreen.ldsOUTSIDE(dx,dy,ddw,ddh,dcolor);

//check
if (dw<1) or (dh<1) then goto skipend;

//get
iscreen.ldc2(area__make(0,0,cw,ch),dx,dy,ddw,ddh,area__make(0,0,dw-1,dh-1),ibuffer2,255,0,clnone,clnone,0,xshowalpha);//top
//.exclude background painting from this area
iscreen.ldbEXCLUDE(true,area__make(dx,dy,dx+ddw-1,dy+ddh-1),xround);

skipend:
except;end;
end;

function tapp.xempty:boolean;
begin
result:=((idw<=1) and (idh<=1)) or (ioutdata.len<5);
end;

function tapp.xscreennotify(sender:tobject):boolean;

   function xzoom(xmag:longint;xmin:boolean):extended;
   begin
   if (xmag<1) then xmag:=1;
   result:=xmag;
   if xmin and (result<1) then result:=1;
   end;

   function yzoom(xmag:longint;xmin:boolean):extended;
   begin
   if (xmag<1) then xmag:=1;
   result:=xmag;
   if xmin and (result<1) then result:=1;
   end;
begin
//defaults
result:=false;

try
//.right click menu
if gui.mouseupstroke and gui.mouseright then rootwin.showmenu2('menu');
except;end;
end;

procedure tapp.xfilter;
begin
if low__setstr(ibufferref,intstr32(iscreenstyle)+'_'+intstr32(xscreencolor)+'_'+intstr32(ibufferid)+'_'+intstr32(idw)+'_'+intstr32(idw)+'_'+intstr32(gui.width)+'_'+intstr32(gui.height)) then imustpaint:=true;
end;

procedure tapp.xonshowmenuFill1(sender:tobject;xstyle:string;xmenudata:tstr8;var ximagealign:longint;var xmenuname:string);
var
   aempty,aimgok:boolean;
begin
try
//check
if zznil(xmenudata,5000) then exit;

//init
xmenuname:='main-app.'+xstyle;
aempty:=xempty;
aimgok:=not aempty;
//menu
if (xstyle='menu') then
   begin
   //file
   low__menutitle(xmenudata,tepnone,'File Options','File options');
   low__menuitem2(xmenudata,tepSave20,'Save','Save Image|Save image to file without prompting','save',100,aknone,xcansave);
   low__menuitem2(xmenudata,tepSave20,'Save A Copy...','Save Image|Save a copy of image to file','saveas2',100,aknone,aimgok);
   end
//settings
else if (xstyle='settings') then
   begin
   //screen color
   low__menutitle(xmenudata,tepnone,'Screen Color','Screen color');
   low__menuitem2(xmenudata,tep__tick(iscreenstyle=0),'Window (Default)','Screen Color|Window color','screenstyle.0',100,aknone,true);
   low__menuitem2(xmenudata,tep__tick(iscreenstyle=1),'Dark Grey','Screen Color|Dark Grey'          ,'screenstyle.1',100,aknone,true);
   low__menuitem2(xmenudata,tep__tick(iscreenstyle=2),'Grey','Screen Color|Grey'                    ,'screenstyle.2',100,aknone,true);
   low__menuitem2(xmenudata,tep__tick(iscreenstyle=3),'Light Screen Color|Grey','Light Grey'        ,'screenstyle.3',100,aknone,true);
   low__menuitem2(xmenudata,tep__tick(iscreenstyle=4),'Black','Screen Color|Black'                  ,'screenstyle.4',100,aknone,true);
   low__menuitem2(xmenudata,tep__tick(iscreenstyle=5),'White','Screen Color|White'                  ,'screenstyle.5',100,aknone,true);
   low__menuitem2(xmenudata,tep__tick(iscreenstyle=6),'Off White','Screen Color|Off White'          ,'screenstyle.6',100,aknone,true);
   low__menuitem2(xmenudata,tep__tick(iscreenstyle=7),'Custom...','Screen Color|Custom'             ,'screenstyle.7',100,aknone,true);
   //batch image conversion
   low__menutitle(xmenudata,tepnone,'Batch Image Conversion','Batch image conversion cettings');
   low__menuitem2(xmenudata,tep__yes(ibatchJPG), 'Save JPG','Batch Image Conversion|Save images with ".jpg" format extension','batch.jpg',100,aknone,true);
   low__menuitem2(xmenudata,tep__yes(ibatchJPEG),'Save JPEG','Batch Image Conversion|Save images with ".jpeg" format extension','batch.jpeg',100,aknone,true);
   low__menuitem2(xmenudata,tep__yes(ibatchJIF) ,'Save JIF','Batch Image Conversion|Save images with ".jif" format extension','batch.jif',100,aknone,true);
   low__menuitem2(xmenudata,tep__yes(ibatchshowafter),'Show folder when complete','Batch Image Conversion|Show batch conversion folder upon completion','batch.showafter',100,aknone,true);
   low__menuitem2(xmenudata,tepFolder20,'Show batch conversion folder','Batch Image Conversion|Show batch conversion folder','batch.showfolder',100,aknone,true);
   //settings
   low__menutitle(xmenudata,tepnone,'Settings','Settings');
   low__menuitem2(xmenudata,tep__yes(ifit),'Fit to window','Image Preview|Fit large images to window','fit',100,aknone,true);
   low__menuitem2(xmenudata,tep__yes(rootwin.xhead.bvisible2['save']),'Show "Save" link','Settings|Show "Save" link on toolbar','show.save',100,aknone,true);
   end;
except;end;
end;

function tapp.xonshowmenuClick1(sender:tbasiccontrol;xstyle:string;xcode:longint;xcode2:string;xtepcolor:longint):boolean;
begin
result:=true;
xcmd(sender,xcode,xcode2);
end;

function mis__makejpeg(s,dout:tobject;ddatacopy:tstr8;ximageaction:string;xmirror,xflip,xgrey,xsepia,xnoise,xinvert,xsoften:boolean;xsizebytes:comp;var e:string):boolean;
label//Note: "ddatacopy" is optional - 03sep2021
   skipend;
var
   d:tobject;//optional
   d8:tstr8;
   sbits,sw,sh,dbits,dw,dh:longint;
   dfree,ddatacopyOK:boolean;
begin
//defaults
result:=false;
dfree:=false;

//init
d:=s;
d8:=nil;
ddatacopyOK:=str__lock(@ddatacopy);

try
//check
if not misok82432(s,sbits,sw,sh) then exit;

//options
if xmirror or xflip or xinvert or xgrey or xsepia or xnoise or xsoften then
   begin
   dfree:=true;
   d:=misimg(sbits,sw,sh);
   if not miscopyareaxx(maxarea,0,0,low__aorb(sw,-sw,xmirror),low__aorb(sh,-sh,xflip),misarea(s),d,s,255,0,clnone,misoptions(xinvert,xgrey,xsepia,xnoise)) then goto skipend;
   if xsoften then misblur82432(d);
   end;

//quality
d8:=str__new8;
if not mis__todata2(d,@d8,'jpg',ia__iadd64(ximageaction,ia_limitsize64,[xsizebytes]),e) then goto skipend;

//output
if misok82432(d,dbits,dw,dh) then
   begin
   if not mis__fromdata(dout,@d8,e) then goto skipend;
   end;
if ddatacopyOK then
   begin
   ddatacopy.clear;
   if not ddatacopy.add(d8) then goto skipend;
   end;

//successful
result:=true;
skipend:
except;end;
//error
try
if not result then
   begin
   if misok82432(d,dbits,dw,dh) then missize(dout,1,1);
   if ddatacopyOK then ddatacopy.clear;
   end;
except;end;
//free
try
str__uaf(@ddatacopy);
str__free(@d8);
if dfree then freeobj(@d);
except;end;
end;

end.
