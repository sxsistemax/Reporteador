unit uImportarReportes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, JvBaseDlg, JvSelectDirectory, uDatos;

type
  TfrmImportarReporte = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    eReporte: TEdit;
    Label2: TLabel;
    eNombreReporte: TEdit;
    foReporte: TFileOpenDialog;
    BitBtn3: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure bAceptarClick(Sender: TObject);
    function Validar: boolean;
  end;

var
  frmImportarReporte: TfrmImportarReporte;

function ImportarReportes( AIdCompania : integer) : Boolean;

implementation

{$R *.dfm}

function ImportarReportes( AIdCompania : integer) : Boolean;
begin
  Result := False;
  with TfrmImportarReporte.Create( Application) do
  begin
    if ShowModal = mrOk then
    begin
      try
        dmDatos.tbReportes.Insert;
        dmDatos.tbReportesIdCompania.Value := AIdCompania;
        dmDatos.tbReportesReporte.Value := eReporte.Text;
        dmDAtos.tbReportes.Post;

        Result := True;

      except
        dmDatos.tbReportes.Cancel;

      end;
    end;
    Free;
  end;
end;

procedure TfrmImportarReporte.bAceptarClick(Sender: TObject);
begin
  if Validar then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmImportarReporte.BitBtn3Click(Sender: TObject);
begin
  if foReporte.Execute then
    eNombreReporte.Text := foReporte.FileName;
end;

function TfrmImportarReporte.Validar: boolean;
begin
  Result := False;
  if eReporte.Text = '' then
  begin
    eReporte.SetFocus;
    ShowMessage( 'Debe digitar el nombre del reporte');

    exit;
  end;

  if eNombreReporte.Text = '' then


  Result := True;
end;

end.
