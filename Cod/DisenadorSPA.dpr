program DisenadorSPA;

uses
  Forms,
  uDisenador in 'uDisenador.pas' {frmDisenador},
  uDatos in 'uDatos.pas' {dmDatos: TDataModule},
  uCompanias in 'uCompanias.pas' {frmCompanias},
  uImportarReportes in 'uImportarReportes.pas' {frmImportarReporte},
  uReportes in 'uReportes.pas' {frmReporte},
  uBaseDatosA2 in '..\..\CompartidosA2\uBaseDatosA2.pas' {dmBasesDatos: TDataModule},
  uTablasConBlobAdministrativo in '..\..\CompartidosA2\uTablasConBlobAdministrativo.pas' {dmAdministrativo: TDataModule},
  uTablasConBlobNomina in '..\..\CompartidosA2\uTablasConBlobNomina.pas' {dmNomina: TDataModule},
  uTablasConBlobContabilidad in '..\..\CompartidosA2\uTablasConBlobContabilidad.pas' {dmContable: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Diseñador Reportes SPA';
  Application.CreateForm(TdmBasesDatos, dmBasesDatos);
  Application.CreateForm(TdmAdministrativo, dmAdministrativo);
  Application.CreateForm(TdmDatos, dmDatos);
  Application.CreateForm(TfrmDisenador, frmDisenador);
  Application.CreateForm(TfrmReporte, frmReporte);
  Application.CreateForm(TdmNomina, dmNomina);
  Application.CreateForm(TdmContable, dmContable);
  Application.Run;
end.
