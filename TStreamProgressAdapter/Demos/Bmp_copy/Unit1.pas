unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, StdCtrls,
  StreamProgressAdapter, ComCtrls, Dialogs;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure Progress(Sender: TObject; Size, CurrentPos: Int64);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Progress;
begin
  Progressbar1.Max := Size;
  Progressbar1.Position := CurrentPos;
  Progressbar1.Refresh;
  Sleep(2000);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  SrcFile: TStreamProgressAdapter;
  DestFile: TFileStream;
  Filename: string;
begin
  if OpenDialog1.Execute then
  begin
    Filename := OpenDialog1.FileName;
    SrcFile := TStreamProgressAdapter.Create(TFileStream.Create(FileName,
      fmOpenRead or fmShareDenyNone));
    try
      SrcFile.OnProgress := Progress;
      DestFile := TFileStream.Create(Filename + '.copy', fmCreate);
      try
        DestFile.CopyFrom(SrcFile, SrcFile.Size);
      finally
        DestFile.Free;
      end;
    finally
      SrcFile.Free;
    end;
  end;
end;

end.

