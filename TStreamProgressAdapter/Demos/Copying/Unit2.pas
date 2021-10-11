unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    edtFrom: TEdit;
    edtTo: TEdit;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private-Deklarationen }
    Canceled: Boolean;
    procedure Progress(Sender: TObject; Size, CurrentPos: Int64);
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  StreamProgressAdapter;

procedure TForm1.Progress;
begin
  Progressbar1.Max := Size;
  Progressbar1.Position := CurrentPos;
  Progressbar1.Refresh;
  if CurrentPos = Size then
    Progressbar1.Position := 0;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  edtFrom.Text := 'c:\tmp\test.mpg';
  edtTo.Text := 'd:\';
end;

procedure TForm1.Button1Click(Sender: TObject);
const
  BlockSize: Integer = 1024;
var
  StreamFrom: TStreamProgressAdapter;
  StreamTo: TFileStream;
  Len: Int64;
  Buffer: Pointer;
begin
  Canceled := False;
  Assert(FileExists(edtFrom.Text), 'Datei existiert nicht');
  StreamFrom := TStreamProgressAdapter.Create(TFileStream.Create(edtFrom.Text, fmOpenRead or fmShareDenyNone));
  try
    StreamFrom.OnProgress := Progress;
    StreamTo := TFileStream.Create(edtTo.Text+'test.mpeg', fmCreate);
    try
      // alocate memory for the buffer
      GetMem(Buffer, 1024);
      try
        while (StreamFrom.Position < StreamFrom.Size) and (not Canceled) do
        begin
          // how much to read
          if StreamFrom.Size - StreamFrom.Position > BlockSize then
            Len := BlockSize
          else
            Len := StreamFrom.Size - StreamFrom.Position;
          // read into the buffer
          StreamFrom.ReadBuffer(Buffer^, Len);
          // write the buffer
          StreamTo.WriteBuffer(Buffer^, Len);
          Application.ProcessMessages;
        end;
      finally
        // clean up the buffer
        FreeMem(Buffer, BlockSize);
      end;
    finally
      // free the destination stream
      FreeAndNil(StreamTo);
    end;
  finally
    // free the source stream
    FreeAndNil(StreamFrom);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Canceled := True;
end;

end.
