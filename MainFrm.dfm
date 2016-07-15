object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'MongoDemo [FireDAC]'
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
  OnDestroy = FormDestroy
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
  object btnRead: TButton
    Left = 208
    Top = 16
    Width = 80
    Height = 25
    Caption = 'Read'
    TabOrder = 2
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
    TabOrder = 3
    OnClick = btnDeleteClick
  end
  object memLog: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 56
    Width = 501
    Height = 457
    Align = alBottom
    TabOrder = 5
  end
  object FDMongoQuery: TFDMongoQuery
    FormatOptions.AssignedValues = [fvStrsTrim2Len]
    FormatOptions.StrsTrim2Len = True
    UpdateOptions.KeyFields = '_id'
    Connection = FDConnection
    Left = 312
    Top = 88
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=Mongo')
    Connected = True
    LoginPrompt = False
    Left = 184
    Top = 136
  end
end
