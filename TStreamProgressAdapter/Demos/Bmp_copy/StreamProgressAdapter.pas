{************************************************************}
{                                                            }
{             StreamProgressAdapter - Version 1.0            }
{                                                            }
{               Copyright (c) 2004 HagenReddman              }
{                                                            }
{  When I die I want 'Hello, world' carved on my headstone.  }
{                                                            }
{************************************************************}



unit StreamProgressAdapter;

interface

uses
  SysUtils, Classes;

type
  TOnProgress = procedure(Sender: TObject; Size, CurrentPos: Int64) of
    object;
  TStreamProgressAdapter = class(TStream)
  private
    FStream: TStream;
    FCurrentPos: Int64;
    FMax: Integer;
    FPercent: Integer;
    FOnProgress: TOnProgress;
  protected
    procedure SetSize(NewSize: Longint); override;
  public
    constructor Create(AStream: TStream);
    destructor Destroy; override;
    function Read(var Buffer; Count: Longint): Longint; override;
    function Write(const Buffer; Count: Longint): Longint; override;
    function Seek(Offset: Longint; Origin: Word): Longint; override;
    procedure DoProgress(Writing: Boolean); virtual;
  published
    property OnProgress: TOnProgress read FOnProgress write FOnProgress;
  end;

implementation

procedure TStreamProgressAdapter.SetSize(NewSize: Longint);
begin
  TStreamProgressAdapter(FStream).SetSize(NewSize);
end;

constructor TStreamProgressAdapter.Create(AStream: TStream);
begin
  inherited Create;
  FStream := AStream;
  FMax := FStream.Size;
  FPercent := 0;
end;

destructor TStreamProgressAdapter.Destroy;
begin
  FStream.Free;
  inherited Destroy;
end;

function TStreamProgressAdapter.Read(var Buffer; Count: Longint): Longint;
begin
  Result := FStream.Read(Buffer, Count);
  FCurrentPos := FStream.Position;
  DoProgress(False);
end;

function TStreamProgressAdapter.Write(const Buffer; Count: Longint): Longint;
begin
  Result := FStream.Write(Buffer, Count);
  DoProgress(False);
end;

function TStreamProgressAdapter.Seek(Offset: Longint; Origin: Word): Longint;
begin
  Result := FStream.Seek(Offset, Origin);
end;

procedure TStreamProgressAdapter.DoProgress(Writing: Boolean);
begin
  //FPercent := Round(100 / FMax * FCurrentPos);
  if Assigned(OnProgress) then
    OnProgress(self, FMax, FCurrentPos);
end;

end.

