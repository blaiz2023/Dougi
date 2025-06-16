program Dougi;

uses
  main in 'main.pas',
  gossgui in 'gossgui.pas',
  gossdat in 'gossdat.pas',
  gossimg in 'gossimg.pas',
  gossio in 'gossio.pas',
  gossnet in 'gossnet.pas',
  gossroot in 'gossroot.pas',
  gosssnd in 'gosssnd.pas',
  gosswin in 'gosswin.pas',
  gossjpg in 'gossjpg.pas',
  gosszip in 'gosszip.pas';

//Important Note: For Borland Delphi 3: If an error of "Can't read form data" or "Resource name not found" occurs during app load or
//                access attempt to D3 -> Project Options, it means there's a conflict between the "app-icon-16-256px.res" and Delphi's default
//                "<app name>.res" file.  Simple Fix: Close the project and shutdown D3, delete the "<app name>.res" file and reload app back into
//                D3 - the default icon will appear in D3's Project Options, but it's safe to ignore this.  The app will be built with the multi icon
//                stored in "app-icon-16-256px.res" specified below - 26apr2025
//
//Include multi-format icon - Delphi 3 can't compile an of 256x256 @ 32 bit -> resource error/out of memory error - 19nov2024
{$R dougi-16-256.res}

begin
//(1)false=event driven disabled, (2)false=file handle caching disabled, (3)true=gui app mode
app__boot(true,false,not isconsole);
end.
