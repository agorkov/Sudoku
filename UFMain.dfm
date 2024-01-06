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
end
