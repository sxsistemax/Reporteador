unit uCompanias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, JvBaseDlg, JvSelectDirectory, uDatos;

type
  TfrmCompanias = class(TForm)
    eCompania: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    eRuta: TEdit;
    bSeleccionar: TBitBtn;
    bAceptar: TBitBtn;
    BitBtn1: TBitBtn;
    sDirectorio: TJvSelectDirectory;
    procedure bSeleccionarClick(Sender: TObject);
    procedure bAceptarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Validar : boolean;
  end;

var
  frmCompanias: TfrmCompanias;

function Companias( AIdCompania : integer) : boolean;

implementation

{$R *.dfm}

function Companias( AIdCompania : integer) : Boolean;
begin
  Result := False;
  with TfrmCompanias.Create( Application) do
  begin
    if (AidCompania <> 0) and
        dmDatos.tbCompanias.Locate( 'IdCompania', AIdCompania, []) then
    begin
      eCompania.Text  := dmDatos.tbCompaniasCompania.Value;
      eRuta.Text      := dmDatos.tbCompaniasRuta.Text;
    end;

    if ShowModal = mrOk then
    begin
      try
        if AidCompania = 0 then
        begin
          dmDatos.tbCompanias.Insert;
        end
        else
        begin
          if dmDatos.tbCompanias.Locate( 'IdCompania', AIdCompania, []) then
            dmDatos.tbCompanias.Edit;
        end;
        dmDatos.tbCompaniasCompania.Value := eCompania.Text;
        dmDatos.tbCompaniasRuta.Value     := eRuta.Text;
        dmDAtos.tbCompanias.Post;

        Result := True;

      except
        dmDatos.tbCompanias.Cancel;

      end;
    end;
    Free;
  end;
end;

procedure TfrmCompanias.bAceptarClick(Sender: TObject);
begin
  if Validar then
  begin
    Close;
    ModalResult := mrOk;
  end;
end;

procedure TfrmCompanias.bSeleccionarClick(Sender: TObject);
begin
  if sDirectorio.Execute then
  begin
    eRuta.Text := sDirectorio.Directory;
  end;
end;

function TfrmCompanias.Validar: boolean;
begin
  Result := False;
  if eCompania.Text = '' then
  begin
    eCompania.SetFocus;
    ShowMessage( 'Debe digitar el nombre de la compañía.');

    exit;
  end;

  if not DirectoryExists( eRuta.Text) then
  begin
    eRuta.SetFocus;
    ShowMessage( 'Debe seleccionar el directorio de la compañía.');
    exit;
  end;
  Result := True;
end;

end.
