object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 688
  ClientWidth = 471
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btn_new_field: TButton
    Left = 352
    Top = 8
    Width = 107
    Height = 25
    Caption = 'btn_new_field'
    TabOrder = 0
    OnClick = btn_new_fieldClick
  end
  object btnHelp: TButton
    Left = 356
    Top = 119
    Width = 107
    Height = 25
    Caption = 'btnHelp'
    TabOrder = 1
    OnClick = btnHelpClick
  end
  object btnSave: TButton
    Left = 352
    Top = 39
    Width = 107
    Height = 25
    Caption = 'btnSave'
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnLoad: TButton
    Left = 352
    Top = 70
    Width = 107
    Height = 25
    Caption = 'btnLoad'
    TabOrder = 3
    OnClick = btnLoadClick
  end
  object btnpossible_values: TButton
    Left = 356
    Top = 144
    Width = 107
    Height = 25
    Caption = 'btnpossible_values'
    TabOrder = 4
    OnClick = btnpossible_valuesClick
  end
  object mmo1: TMemo
    Left = 0
    Top = 352
    Width = 471
    Height = 336
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 5
  end
end
