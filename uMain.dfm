object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #45936#51060#53552' '#48373#50896
  ClientHeight = 223
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = HANGEUL_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = #47569#51008' '#44256#46357
  Font.Style = []
  TextHeight = 15
  object lbPath: TLabel
    Left = 8
    Top = 13
    Width = 48
    Height = 15
    Caption = #49444#52824#44221#47196
  end
  object lbUserID: TLabel
    Left = 8
    Top = 42
    Width = 48
    Height = 15
    Caption = #49324#50857#51088#47749
  end
  object lbPassword: TLabel
    Left = 8
    Top = 71
    Width = 48
    Height = 15
    Caption = #48708#48128#48264#54840
  end
  object lbFileName: TLabel
    Left = 8
    Top = 100
    Width = 36
    Height = 15
    Caption = #54028#51068#47749
  end
  object ePath: TEdit
    Left = 72
    Top = 10
    Width = 289
    Height = 23
    TabOrder = 0
    Text = 'C:\Program Files\MariaDB 10.10\bin'
  end
  object eUserID: TEdit
    Left = 72
    Top = 39
    Width = 289
    Height = 23
    TabOrder = 1
  end
  object ePassword: TEdit
    Left = 72
    Top = 68
    Width = 289
    Height = 23
    PasswordChar = '*'
    TabOrder = 2
  end
  object eFileName: TEdit
    Left = 72
    Top = 97
    Width = 289
    Height = 23
    ReadOnly = True
    TabOrder = 3
  end
  object btnFind: TButton
    Left = 272
    Top = 128
    Width = 89
    Height = 25
    Caption = #52286#50500#48372#44592'...'
    TabOrder = 4
    OnClick = btnFindClick
  end
  object btnExecute: TButton
    Left = 176
    Top = 191
    Width = 89
    Height = 25
    Caption = #49892#54665
    TabOrder = 5
    OnClick = btnExecuteClick
  end
  object btnCancel: TButton
    Left = 270
    Top = 191
    Width = 89
    Height = 25
    Caption = #52712#49548
    TabOrder = 6
    OnClick = btnCancelClick
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.sql'
    Filter = #48177#50629' '#54028#51068'(*.sql)|*.sql'
    Left = 8
    Top = 144
  end
end
