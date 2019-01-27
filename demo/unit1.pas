unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, windows, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, wWinServices, gvector;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnStatus: TButton;
    btnStart: TButton;
    btnStop: TButton;
    btnGetList: TButton;
    edServiceName: TEdit;
    mLog: TMemo;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure btnStartClick(Sender: TObject);
    procedure btnStatusClick(Sender: TObject);
    procedure btnStopClick(Sender: TObject);
    procedure btnGetListClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private

  protected
    fWinServices: TWinServices;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.btnStatusClick(Sender: TObject);
begin
  mLog.Append(fWinServices.ServiceGetStatusText('',edServiceName.Text));
end;

procedure TForm1.btnStopClick(Sender: TObject);
begin
  if fWinServices.ServiceStop('',edServiceName.Text) then
    mLog.Append('Stopped')
  else
    mLog.Append('Error');
end;

procedure TForm1.btnGetListClick(Sender: TObject);
var
  i: Integer;
  aList: TwServices;
begin
  try
    aList:= fWinServices.ServicesList;

    mLog.Append('-= Start List =-');

    for i:=0 to aList.Size-1 do
      mLog.Append(Format('%s | %s',[aList[i].Name, aList[i].StatusText]));

    mLog.Append('-= End List =-');
  finally
    FreeAndNil(aList);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fWinServices:= TWinServices.Create;

  mLog.Append('User who started the application: '+ fWinServices.UserCurrentName );


  mLog.Append('ComputerName: '+ fWinServices.ComputerName);

  mLog.Append('To start or stop services, run the application as an administrator.');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fWinServices);
end;

procedure TForm1.btnStartClick(Sender: TObject);
begin
  if fWinServices.ServiceStart('',edServiceName.Text) then
    mLog.Append('Started')
  else
    mLog.Append('Error');
end;

end.

