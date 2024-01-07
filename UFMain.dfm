object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 688
  ClientWidth = 887
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
    Left = 768
    Top = 16
    Width = 107
    Height = 25
    Caption = 'btn_new_field'
    TabOrder = 0
    OnClick = btn_new_fieldClick
  end
  object btnHelp: TButton
    Left = 772
    Top = 127
    Width = 107
    Height = 25
    Caption = 'btnHelp'
    TabOrder = 1
    OnClick = btnHelpClick
  end
  object btnSave: TButton
    Left = 768
    Top = 47
    Width = 107
    Height = 25
    Caption = 'btnSave'
    TabOrder = 2
    OnClick = btnSaveClick
  end
  object btnLoad: TButton
    Left = 768
    Top = 78
    Width = 107
    Height = 25
    Caption = 'btnLoad'
    TabOrder = 3
    OnClick = btnLoadClick
  end
  object btnpossible_values: TButton
    Left = 772
    Top = 152
    Width = 107
    Height = 25
    Caption = 'btnpossible_values'
    TabOrder = 4
    OnClick = btnpossible_valuesClick
  end
end
