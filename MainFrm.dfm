object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'MongoDemo'
  ClientHeight = 516
  ClientWidth = 507
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object btnConnect: TButton
    Left = 16
    Top = 16
    Width = 80
    Height = 25
    Caption = 'Connect'
    TabOrder = 0
    OnClick = btnConnectClick
  end
  object btnAdd: TButton
    Left = 112
    Top = 16
    Width = 80
    Height = 25
    Caption = 'Create'
    TabOrder = 1
    OnClick = btnAddClick
  end
  object memLog: TJvMemo
    AlignWithMargins = True
    Left = 3
    Top = 66
    Width = 501
    Height = 447
    Align = alBottom
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      '')
    ParentFont = False
    TabOrder = 2
  end
  object btnRead: TButton
    Left = 208
    Top = 16
    Width = 80
    Height = 25
    Caption = 'Read'
    TabOrder = 3
    OnClick = btnReadClick
  end
  object btnUpdate: TButton
    Left = 304
    Top = 16
    Width = 80
    Height = 25
    Caption = 'Update'
    TabOrder = 4
    OnClick = btnUpdateClick
  end
  object btnDelete: TButton
    Left = 400
    Top = 16
    Width = 80
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = btnDeleteClick
  end
end
