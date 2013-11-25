unit uReportes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, JvBaseDlg, JvSelectDirectory, uDatos;

type
  TfrmReporte = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    eReporte: TEdit;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure bAceptarClick(Sender: TObject);
    function Validar: boolean;
  end;

var
  frmReporte: TfrmReporte;

function Reportes( AIdCompania, AIdReporte : integer) : Boolean;

implementation

{$R *.dfm}

function Reportes( AIdCompania, AIdReporte : integer) : Boolean;
begin
  Result := False;
  with TfrmReporte.Create( Application) do
  begin
    if (AidReporte <> 0) and
        dmDatos.tbReportes.Locate( 'IdCompania;IdReporte', VarArrayOf( [AIdCompania, AIdReporte]), []) then
    begin
      eReporte.Text  := dmDatos.tbReportesReporte.Value;
    end;

    if ShowModal = mrOk then
    begin
      try
        if AidReporte = 0 then
        begin
          dmDatos.tbReportes.Insert;
        end
        else
        begin
          dmDatos.tbReportes.Edit;
        end;
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

procedure TfrmReporte.bAceptarClick(Sender: TObject);
begin
  if Validar then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmReporte.FormActivate(Sender: TObject);
begin
  eReporte.SetFocus();
end;

function TfrmReporte.Validar: boolean;
begin
  Result := False;
  if eReporte.Text = '' then
  begin
    eReporte.SetFocus;
    ShowMessage( 'Debe digitar el nombre del reporte');
    exit;
  end;

  Result := True;
end;

end.
