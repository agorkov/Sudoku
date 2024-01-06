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
  object Edit1: TEdit
    Tag = 12
    Left = 392
    Top = 352
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
    OnChange = Edit1Change
  end
  object btnHelp: TButton
    Left = 772
    Top = 127
    Width = 107
    Height = 25
    Caption = 'btnHelp'
    TabOrder = 2
    OnClick = btnHelpClick
  end
  object btnSave: TButton
    Left = 768
    Top = 47
    Width = 107
    Height = 25
    Caption = 'btnSave'
    TabOrder = 3
    OnClick = btnSaveClick
  end
  object btnLoad: TButton
    Left = 768
    Top = 78
    Width = 107
    Height = 25
    Caption = 'btnLoad'
    TabOrder = 4
    OnClick = btnLoadClick
  end
end
