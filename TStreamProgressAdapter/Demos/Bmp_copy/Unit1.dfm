object Form1: TForm1
  Left = 248
  Top = 127
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Bmp copy'
  ClientHeight = 66
  ClientWidth = 300
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 120
  TextHeight = 16
  object Button1: TButton
    Left = 192
    Top = 32
    Width = 97
    Height = 25
    Caption = '&Copy'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 8
    Width = 281
    Height = 17
    Smooth = True
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Bitmap (*.bmp)|*.bmp'
    Left = 8
    Top = 32
  end
end
