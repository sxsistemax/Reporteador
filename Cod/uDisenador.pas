unit uDisenador;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, pngimage, ExtCtrls, uDatos, DBCtrls, ComCtrls,
  JvExComCtrls, JvDBTreeView, DB, Buttons, uCompanias, Grids, DBGrids, ImgList,
  ActnList, Menus, uUtilidades, uReportes, JvListView, OnGuard;

type
  TfrmDisenador = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Iconos: TImageList;
    ActionList1: TActionList;
    ImagenesDatabase: TImageList;
    MenuReportes: TPopupMenu;
    NuevaCia: TAction;
    EditarCia: TAction;
    BorrarCia: TAction;
    NuevoRep: TAction;
    BorrarRep: TAction;
    DuplicarReporte: TAction;
    NuevoReporte1: TMenuItem;
    DuplicarReporte1: TMenuItem;
    DisearReporte1: TMenuItem;
    BorrarReporte1: TMenuItem;
    Label2: TLabel;
    dbListCompanias: TDBLookupListBox;
    dbListReportes: TDBLookupListBox;
    Label3: TLabel;
    MenuCompanias: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    N1: TMenuItem;
    NuevoReporte2: TMenuItem;
    ImportarRep: TAction;
    DisenarRep: TAction;
    Importar1: TMenuItem;
    bRegistro: TBitBtn;
    BitBtn1: TBitBtn;
    procedure MenuReportesPopup(Sender: TObject);
    procedure NuevaCiaExecute(Sender: TObject);
    procedure EditarCiaExecute(Sender: TObject);
    procedure NuevoRepExecute(Sender: TObject);
    procedure BorrarCiaExecute(Sender: TObject);
    procedure DuplicarReporteExecute(Sender: TObject);
    procedure BorrarRepExecute(Sender: TObject);
    procedure DisenarRepExecute(Sender: TObject);
    procedure dbListCompaniasClick(Sender: TObject);
    procedure dbListReportesDblClick(Sender: TObject);
    procedure MenuCompaniasPopup(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bRegistroClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FIdCompania : integer;
    FIdReporte  : integer;
    Procedure Deshabilitar;
    Procedure Habilitar(AIdCompania, AIdReporte : integer);
    procedure MostrarReporte( AIdReporte : integer);
    procedure RefrescarReportes;
    procedure CargarDatosAplicaion;
  end;

var
  frmDisenador: TfrmDisenador;

implementation

{$R *.dfm}

uses uUtilidadesSPA, uSeguridad;

Const
  IdentificadorAplicacion : TKey = ($73,$8F,$16,$A1,$6F,$B4,$CB,$B4,$70,$89,$2D,$48,$9A,$C1,$4F,$9A);


procedure TfrmDisenador.BitBtn1Click(Sender: TObject);
begin
  if Confirmar('¿ Esta seguro de salir de la apliación ?') then
    Close;
end;

procedure TfrmDisenador.BorrarCiaExecute(Sender: TObject);
begin
  if Confirmar( 'Desea borrar la compañía ?') then
  begin
    if dmDatos.tbReportes.Locate('IdCompania', dmDatos.qrReportesIdCompania.Value, []) then
      ShowMessage('No se puede borrar la compañía por que tiene reportes creados.')
    else
    begin
      dmDatos.tbCompanias.Delete;
    end;
  end;
end;

procedure TfrmDisenador.BorrarRepExecute(Sender: TObject);
var
  S : string;
begin
  if Confirmar( 'Desea borrar el reporte ?') then
  begin
    if dmDatos.tbReportes.Locate('IdReporte', dmDatos.qrReportesIdReporte.Value, []) then
    begin
      if Confirmar( 'Desea borrar el reporte fisicamente?') then
      begin
        S := gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3';
        if DeleteFile(S) then;

      end;
      dmDatos.tbReportes.Delete;


      RefrescarReportes;
    end
    else
      ShowMessage( 'No se puede borrar el reporte.');
  end;
end;

procedure TfrmDisenador.bRegistroClick(Sender: TObject);
begin
  MostrarRegistrado;
end;

procedure TfrmDisenador.CargarDatosAplicaion;
begin
  Key := IdentificadorAplicacion;
end;

procedure TfrmDisenador.dbListCompaniasClick(Sender: TObject);
begin
  RefrescarReportes;
end;

procedure TfrmDisenador.Deshabilitar;
begin
  NuevaCia.Enabled := False;
  EditarCia.Enabled := False;
  BorrarCia.Enabled := False;
  NuevoRep.Enabled  := False;
  DuplicarReporte.Enabled := False;
  DisenarRep.Enabled := False;
  BorrarRep.Enabled := False;
end;

procedure TfrmDisenador.DuplicarReporteExecute(Sender: TObject);
begin
  if ModoDemo and
    ((dbListReportes.ListSource.DataSet.RecordCount > 0)) then
  begin
    ShowMessage('En modo demo solo puede crear una compañía y un reporte.');
    exit;
  end;

  if dmDatos.qrReportesIdReporte.Value <> 0  then
  begin
    Reportes(dmDatos.qrReportesIdCompania.Value, dmDatos.qrReportesIdReporte.Value);
    RefrescarReportes;
  end;
end;

procedure TfrmDisenador.EditarCiaExecute(Sender: TObject);
begin
  if dbListCompanias.KeyValue > 0  then
  begin
    if Companias( dmDatos.tbCompaniasIdCompania.Value) then
      ;
  end;
end;

procedure TfrmDisenador.FormCreate(Sender: TObject);
begin
  CargarDatosAplicaion;

  ModoDemo := True;

  ValidarRegistro( ModoDemo) ;

end;

procedure TfrmDisenador.Habilitar(AIdCompania, AIdReporte : integer);
begin
  if AIdCompania = 0 then
    NuevaCia.Enabled := True;

  if AIdCompania <> 0 then
  begin
    NuevaCia.Enabled := True;
    EditarCia.Enabled := True;
    BorrarCia.Enabled := True;
    NuevoRep.Enabled := True;
  end
  else
    if AIdReporte <> 0 then
    begin
      NuevoRep.Enabled := True;
      DuplicarReporte.Enabled := True;
      DisenarRep.Enabled := True;
      BorrarRep.Enabled := True;
    end;
end;


procedure TfrmDisenador.MenuCompaniasPopup(Sender: TObject);
begin
  Deshabilitar;
  if (dbListCompanias.SelectedItem <> '') and (dbListCompanias.KeyValue > 0) then
  begin
    Habilitar(dmDatos.tbCompaniasIdCompania.Value, 0);
  end
  else
    Habilitar(0, 0);
end;

procedure TfrmDisenador.MenuReportesPopup(Sender: TObject);
begin
  Deshabilitar;
  if dbListCompanias.KeyValue > 0 then
    Habilitar(dmDatos.tbCompaniasIdCompania.Value, 0);
  if dbListReportes.KeyValue > 0 then
    Habilitar(0, dmDatos.qrReportesIdReporte.Value)

end;

procedure TfrmDisenador.MostrarReporte(AIdReporte: integer);
begin
  dmDatos.CrearTablas;

  if FileExists(gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3')  then
  begin
    dmDatos.Reporte.LoadFromFile(gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3');
    dmDatos.Reporte.ShowReport(True);
  end
  Else
    ShowMessage('No se encontro el reporte, por favor revise.');
end;

procedure TfrmDisenador.NuevaCiaExecute(Sender: TObject);
begin
  if ModoDemo and
    ( (dbListCompanias.ListSource.DataSet.RecordCount > 0) ) then
  begin
    ShowMessage('En modo demo solo puede crear una compañía y un reporte.');
    exit;
  end;

  if Companias( 0) then ;
end;

procedure TfrmDisenador.DisenarRepExecute(Sender: TObject);
begin
  if (dmDatos.qrReportesIdCompania.Value <> 0) and
    (dmDatos.qrReportesIdReporte.Value <> 0) then
  begin
    dmDatos.CrearTablas;

    dmDatos.Reporte.Clear;

    if not FileExists(gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3')  then
      dmDatos.Reporte.SaveToFile(gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3');

    dmDatos.Reporte.LoadFromFile(gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3');
    dmDatos.Reporte.DesignReport;
  end;
end;

procedure TfrmDisenador.NuevoRepExecute(Sender: TObject);
begin
  if ModoDemo and
    ((dbListReportes.ListSource.DataSet.RecordCount > 0)) then
  begin
    ShowMessage('En modo demo solo puede crear una compañía y un reporte.');
    exit;
  end;

  if dbListCompanias.KeyValue > 0  then
  begin
    if Reportes(dmDatos.tbCompaniasIdCompania.Value, 0) then
    begin
      dmDatos.CrearTablas;

      if not FileExists(gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3')  then
        dmDatos.Reporte.SaveToFile(gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3');

      dmDatos.Reporte.LoadFromFile(gRutaReportes + dmDatos.qrReportesReporte.Value + '.fr3');
      dmDatos.Reporte.DesignReport;
      RefrescarReportes;
    end;
  end;
end;

procedure TfrmDisenador.RefrescarReportes;
begin
  if dbListCompanias.KeyValue > 0  then
  begin
    with dmDatos do
    begin
      ReportesCompania(tbCompaniasIdCompania.Value);
    end;
  end;

end;

procedure TfrmDisenador.dbListReportesDblClick(Sender: TObject);
begin
  if dbListReportes.KeyValue > 0 then
    MostrarReporte(dbListReportes.KeyValue);
end;


end.
