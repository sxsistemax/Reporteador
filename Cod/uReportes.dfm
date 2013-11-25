object frmReporte: TfrmReporte
  Left = 227
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Reporte'
  ClientHeight = 87
  ClientWidth = 437
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 39
    Height = 13
    Caption = 'Reporte'
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 54
    Width = 75
    Height = 25
    DoubleBuffered = True
    Kind = bkCancel
    ParentDoubleBuffered = False
    TabOrder = 0
  end
  object BitBtn2: TBitBtn
    Left = 89
    Top = 54
    Width = 75
    Height = 25
    Caption = 'Aceptar'
    DoubleBuffered = True
    Kind = bkOK
    ParentDoubleBuffered = False
    TabOrder = 1
  end
  object eReporte: TEdit
    Left = 8
    Top = 27
    Width = 417
    Height = 21
    TabOrder = 2
  end
end
