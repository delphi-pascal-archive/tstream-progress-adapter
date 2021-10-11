object Form1: TForm1
  Left = 251
  Top = 131
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Copying'
  ClientHeight = 130
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 64
    Height = 16
    Caption = 'Copy from:'
  end
  object Label2: TLabel
    Left = 8
    Top = 48
    Width = 49
    Height = 16
    Caption = 'Copy to:'
  end
  object edtFrom: TEdit
    Left = 80
    Top = 8
    Width = 425
    Height = 24
    TabOrder = 0
  end
  object edtTo: TEdit
    Left = 80
    Top = 40
    Width = 425
    Height = 24
    TabOrder = 1
  end
  object Button1: TButton
    Left = 408
    Top = 72
    Width = 97
    Height = 25
    Caption = 'Copy'
    TabOrder = 2
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 104
    Width = 497
    Height = 17
    Smooth = True
    TabOrder = 3
  end
  object Button2: TButton
    Left = 304
    Top = 72
    Width = 97
    Height = 25
    Caption = 'Cancel'
    TabOrder = 4
    OnClick = Button2Click
  end
end
