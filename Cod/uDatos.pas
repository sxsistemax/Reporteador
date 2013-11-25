unit uDatos;

interface

uses
  SysUtils, Classes, DB, dbTables, dbisamtb, frxClass, frxDBSet, pngimage, Dialogs,
  JvBaseDlg, JvProgressDialog, Variants, frxDesgn, frxChart,
  frxDCtrl, frxDMPExport, frxGradient, frxChBox, frxCross, frxRich, frxBarcode,
  frxExportCSV, frxExportText, frxExportRTF, frxExportPDF, frxDBI4Components;

type
  TdmDatos = class(TDataModule)
    dbReportes: TDBISAMDatabase;
    tbReportes: TDBISAMTable;
    tbCompanias: TDBISAMTable;
    tbReportesIdReporte: TAutoIncField;
    tbReportesIdCompania: TIntegerField;
    tbReportesReporte: TStringField;
    tbCompaniasIdCompania: TAutoIncField;
    tbCompaniasCompania: TStringField;
    tbCompaniasRuta: TStringField;
    Reporte: TfrxReport;
    frxDesigner1: TfrxDesigner;
    dsCompanias: TDataSource;
    dsReportes: TDataSource;
    qrReportes: TDBISAMQuery;
    qrReportesIdCompania: TAutoIncField;
    qrReportesIdReporte: TIntegerField;
    qrReportesReporte: TStringField;
    frxPDFExport1: TfrxPDFExport;
    frxRTFExport1: TfrxRTFExport;
    frxSimpleTextExport1: TfrxSimpleTextExport;
    frxCSVExport1: TfrxCSVExport;
    frxBarCodeObject1: TfrxBarCodeObject;
    frxRichObject1: TfrxRichObject;
    frxCrossObject1: TfrxCrossObject;
    frxCheckBoxObject1: TfrxCheckBoxObject;
    frxGradientObject1: TfrxGradientObject;
    frxDotMatrixExport1: TfrxDotMatrixExport;
    frxDialogControls1: TfrxDialogControls;
    frxChartObject1: TfrxChartObject;
    pProgreso: TJvProgressDialog;
    frxDBI4Components1: TfrxDBI4Components;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FIdCompaniaActual: integer;
    procedure CrearTablas;
    procedure BorrarTablas;
    procedure ReportesCompania(AIdCompania: integer);
  end;

const
  kDatos = 'Datos\';
  kReportes = 'Reportes\';

var
  dmDatos: TdmDatos;

  gRutaReportes: String;

implementation

uses uBaseDatosA2, uTablasConBlobAdministrativo, uTablasConBlobNomina,
  uTablasConBlobContabilidad;

{$R *.dfm}

procedure TdmDatos.BorrarTablas;
var
  i: integer;
begin
  // Busca las tablas de DBIsam que se crearon dinamicamente
  for i := ComponentCount - 1 downto 0 do
  begin
    if (Components[i].Tag = 10) or (Components[i].Tag = 100) then
      Components[i].Free();
  end;
end;

procedure TdmDatos.CrearTablas;
var
  T: TDBISAMTable;

  i: integer;
  F: TSearchRec;
  S: String;
  Ruta: String;
  P : TFloatField;

  procedure AdicionarDataSetAReporte( Tabla : TDBISAMTable);
  var
    frDS: TfrxDBDataset;
    AdicionarDS : Boolean;
    i : integer;
  begin
    AdicionarDS := True;

    // Busca los si la tabla no esta creada en el reporte

    for i := 0 to Reporte.DataSets.Count - 1 do
    begin
      frDS := Reporte.DataSets[i].DataSet as TfrxDBDataset;

      if frDS.Name = '_' + Tabla.Name then
      begin
        AdicionarDS := False;
        Exit;
      end;

    end;

    if AdicionarDS then
    begin
      frDS := TfrxDBDataset.Create(Self);
      frDS.Tag := 10;

      With frDS do
      begin
        DataSet := Tabla;
        Name := '_' + Tabla.Name;
        Visible := False;
        UserName := Tabla.Name;
      end;

      Tabla.Active := False;

      // Adiciona el dataset al reporte
      Reporte.DataSets.Add(frDS);
    end;
  end;

  // Adiciona la tabla
  procedure AdicionarTabla( db : TDBISAMDatabase; Nombre, NombreTabla : string);
  begin
    try
      T := TDBISAMTable.Create(self);
      T.Tag := 100;
      T.DatabaseName := db.DatabaseName;
      T.Name := Nombre;
      T.TableName := NombreTabla;

      // Crea el dataset para el reporte
      AdicionarDataSetAReporte( T);
    Except
      T.Free;
    end;
  end;

begin
  if dbReportes.Connected then
  begin
    BorrarTablas;


    FIdCompaniaActual := qrReportesIdCompania.Value;

    Ruta := tbCompaniasRuta.Value;

    pProgreso.Show;

    try
      dmBasesDatos.ConectarDB( Ruta);

      try
        Reporte.DataSets.Clear;

        FindFirst(Ruta + '\*.dat', 0, F);
        pProgreso.Max := 100;
        pProgreso.Show;
        i := 1;

        repeat
          pProgreso.Position := i;

          S := UpperCase(ChangeFileExt(ExtractFileName(F.Name), ''));

          if (S <> 'A2CONVERSION') then
          // Crea la tabla
          try
            if
              // Tablas Administrativas
                  (S <> 'SFIXED')
              and (S <> 'SOPERACIONINV')
              and (S <> 'SCUENTASXCOBRAR')
              and (S <> 'SCUENTASXPAGAR')
              and (S <> 'SDETALLEVENTA')

              // Tablas Contabilidad
              and (S <> 'A2CAUXILIARESSALDO')
              and (S <> 'A2CCUENTAS')

              // Tablas Nomina
              and (S <> UpperCase('a2AcumConcepto'))
              and (S <> UpperCase('a2AcumGenDetalle'))
              and (S <> UpperCase('a2Concepto'))
              and (S <> UpperCase('a2Incremento'))
              and (S <> UpperCase('a2Tabla'))

                                          then
            begin
              AdicionarTabla( dmBasesDatos.dbA2, S, F.Name);

              Inc(i);
            end
            else
            begin
              if (S = 'SFIXED') Then
                AdicionarDataSetAReporte( dmAdministrativo.sFixed);
              if (S = 'SOPERACIONINV') then
                AdicionarDataSetAReporte( dmAdministrativo.sOperacionInv);
              if (S = 'SDETALLEVENTA') then
                AdicionarDataSetAReporte( dmAdministrativo.sDetalleVenta);
              if (S = 'SCUENTASXCOBRAR') then
                AdicionarDataSetAReporte( dmAdministrativo.sCuentasXCobrar);
              if (S = 'SCUENTASXPAGAR') then
                AdicionarDataSetAReporte( dmAdministrativo.sCuentasXPagar);
              if (S = 'A2CAUXILIARESSALDO') then
                AdicionarDataSetAReporte( dmContable.A2CAUXILIARESSALDO);
              if (S = 'A2CCUENTAS') then
                AdicionarDataSetAReporte( dmContable.A2CCUENTAS);

              // Tablas Nomina
              if (S = UpperCase('a2AcumConcepto')) then
                AdicionarDataSetAReporte( dmNomina.a2AcumConcepto);
              if (S = UpperCase('a2AcumGenDetalle')) then
                AdicionarDataSetAReporte( dmNomina.a2AcumGenDetalle);
              if (S = UpperCase('a2Concepto')) then
                AdicionarDataSetAReporte( dmNomina.a2Concepto);
              if (S = UpperCase('a2Incremento')) then
                AdicionarDataSetAReporte( dmNomina.a2Incremento);
              if (S = UpperCase('a2Tabla')) then
                AdicionarDataSetAReporte( dmNomina.a2Tabla);
            end;
          Except
          End;
        until FindNext(F) <> 0;
      except
        dmBasesDatos.CerrarDB;
        ShowMessage('No se pudo cargar las tablas de la compañia.');
      end;
    except
      ShowMessage('No se pudo conectar a los datos de la compañía.');
    end;
    pProgreso.Hide;

  end;
end;

procedure TdmDatos.DataModuleCreate(Sender: TObject);
var
  R: string;
begin
  // Carga la ruta base para los directorios de control
  R := ExtractFilePath(ParamStr(0));

  // Carga la ruta base para los reportes
  gRutaReportes := R + kReportes;

  // Revisa si existe el directorio de datos
  if Not DirectoryExists(R + kDatos) then
    CreateDir(R + kDatos);

  // Revisa si existe el directorio de reportes
  if Not DirectoryExists(gRutaReportes) then
    CreateDir(gRutaReportes);

  dbReportes.Connected := False;
  dbReportes.Directory := R + kDatos;
  dbReportes.Connected := True;

  try
    tbCompanias.Open;
  except
    tbCompanias.CreateTable();
    tbCompanias.Open;
  end;

  try
    tbReportes.Open;
  except
    tbReportes.CreateTable();
    tbReportes.Open;
  end;

end;

procedure TdmDatos.DataModuleDestroy(Sender: TObject);
begin
  tbCompanias.Close;
  tbReportes.Close;

  dbReportes.Close;

  BorrarTablas;
end;

procedure TdmDatos.ReportesCompania(AIdCompania: integer);
begin
  try
    qrReportes.Close;
    qrReportes.ParamByName('IdCompania').Value := AIdCompania;
    qrReportes.Open;
  except
  end;
end;

end.
