object dmDatos: TdmDatos
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 530
  Width = 497
  object dbReportes: TDBISAMDatabase
    EngineVersion = '4.29 Build 1'
    DatabaseName = 'Reportes'
    SessionName = 'Default'
    Left = 16
    Top = 16
  end
  object tbReportes: TDBISAMTable
    AutoDisplayLabels = True
    DatabaseName = 'Reportes'
    EngineVersion = '4.29 Build 1'
    FieldDefs = <
      item
        Name = 'IdReporte'
        DataType = ftAutoInc
      end
      item
        Name = 'IdCompania'
        DataType = ftInteger
      end
      item
        Name = 'Reporte'
        DataType = ftString
        Size = 100
      end>
    IndexDefs = <
      item
        Name = 'tbReportesDBISA1'
        Fields = 'RecordID'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'idxIdCompania'
        Fields = 'IdCompania'
      end>
    TableName = 'SPAReportes'
    StoreDefs = True
    Left = 176
    Top = 16
    object tbReportesIdReporte: TAutoIncField
      FieldName = 'IdReporte'
      Origin = 'SPAReportes.IdReporte'
    end
    object tbReportesIdCompania: TIntegerField
      FieldName = 'IdCompania'
      Origin = 'SPAReportes.IdCompania'
    end
    object tbReportesReporte: TStringField
      FieldName = 'Reporte'
      Origin = 'SPAReportes.Reporte'
      Size = 100
    end
  end
  object tbCompanias: TDBISAMTable
    AutoDisplayLabels = True
    DatabaseName = 'Reportes'
    EngineVersion = '4.29 Build 1'
    FieldDefs = <
      item
        Name = 'IdCompania'
        DataType = ftAutoInc
      end
      item
        Name = 'Compania'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'Ruta'
        DataType = ftString
        Size = 200
      end>
    TableName = 'SPACompanias'
    StoreDefs = True
    Left = 96
    Top = 16
    object tbCompaniasIdCompania: TAutoIncField
      FieldName = 'IdCompania'
      Origin = 'SPACompanias.IdCompania'
    end
    object tbCompaniasCompania: TStringField
      FieldName = 'Compania'
      Origin = 'SPACompanias.Compania'
      Size = 100
    end
    object tbCompaniasRuta: TStringField
      FieldName = 'Ruta'
      Origin = 'SPACompanias.Ruta'
      Size = 200
    end
  end
  object Reporte: TfrxReport
    Version = '4.14'
    DataSetName = 'Clientes'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Por defecto'
    PrintOptions.PrintOnSheet = 0
    PrintOptions.PrintPages = ppEven
    ReportOptions.CreateDate = 40890.844064131950000000
    ReportOptions.LastChange = 41684.645775243060000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    OnPrintPage = ReportePrintPage
    Left = 56
    Top = 168
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 215.900000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 1
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
    end
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 112
    Top = 168
  end
  object dsCompanias: TDataSource
    AutoEdit = False
    DataSet = tbCompanias
    Left = 88
    Top = 72
  end
  object dsReportes: TDataSource
    AutoEdit = False
    DataSet = qrReportes
    Left = 176
    Top = 72
  end
  object qrReportes: TDBISAMQuery
    DatabaseName = 'Reportes'
    EngineVersion = '4.29 Build 1'
    SQL.Strings = (
      'select SPAReportes.IdCompania, SPAReportes.IdReporte, '
      'SPAReportes.Reporte '
      'from  SPAReportes'
      'Where IdCompania = :IdCompania')
    Params = <
      item
        DataType = ftInteger
        Name = 'IdCompania'
        Value = '0'
      end>
    Left = 16
    Top = 72
    ParamData = <
      item
        DataType = ftInteger
        Name = 'IdCompania'
        Value = '0'
      end>
    object qrReportesIdCompania: TAutoIncField
      FieldName = 'IdCompania'
    end
    object qrReportesIdReporte: TIntegerField
      FieldName = 'IdReporte'
    end
    object qrReportesReporte: TStringField
      FieldName = 'Reporte'
      Size = 100
    end
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    Left = 152
    Top = 240
  end
  object frxRTFExport1: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 216
    Top = 264
  end
  object frxSimpleTextExport1: TfrxSimpleTextExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Frames = False
    EmptyLines = False
    OEMCodepage = False
    DeleteEmptyColumns = True
    Left = 88
    Top = 264
  end
  object frxCSVExport1: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 24
    Top = 240
  end
  object frxBarCodeObject1: TfrxBarCodeObject
    Left = 40
    Top = 344
  end
  object frxRichObject1: TfrxRichObject
    Left = 104
    Top = 328
  end
  object frxCrossObject1: TfrxCrossObject
    Left = 160
    Top = 352
  end
  object frxCheckBoxObject1: TfrxCheckBoxObject
    Left = 232
    Top = 336
  end
  object frxGradientObject1: TfrxGradientObject
    Left = 304
    Top = 352
  end
  object frxDotMatrixExport1: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 48
    Top = 456
  end
  object frxDialogControls1: TfrxDialogControls
    Left = 160
    Top = 456
  end
  object frxChartObject1: TfrxChartObject
    Left = 264
    Top = 456
  end
  object pProgreso: TJvProgressDialog
    Left = 408
    Top = 32
  end
  object frxDBI4Components1: TfrxDBI4Components
    Left = 368
    Top = 456
  end
  object fxComponentes: TfrxDBI4Components
    Left = 368
    Top = 144
  end
end
