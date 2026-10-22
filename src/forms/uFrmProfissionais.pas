unit uFrmProfissionais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, System.Math,
  Vcl.ExtCtrls, System.RegularExpressions, System.StrUtils, uProfissional, uProfissionalService;

type
  TfrmProfissionaisRegistrar = class(TForm)
    pnPrincipal: TPanel;
    lblName: TLabel;
    lblBio: TLabel;
    edtNome: TEdit;
    mmBio: TMemo;
    tbCategorias: TToolBar;
    btnVoltar: TToolButton;
    btnCancelar: TToolButton;
    btnDeletar: TToolButton;
    btnAtualizar: TToolButton;
    btnInserir: TToolButton;
    btnPesquisar: TToolButton;
    btnConfirmar: TToolButton;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    Label1: TLabel;
    edtTelefone: TEdit;
    procedure edtTelefoneChange(Sender: TObject);
  private
    { Private declarations }
    function FormatarTelefone(sTelefone: string): string;
  public
    { Public declarations }
  end;

var
  frmProfissionaisRegistrar: TfrmProfissionaisRegistrar;

implementation

{$R *.dfm}

{ TfrmProfissionaisRegistrar }

procedure TfrmProfissionaisRegistrar.edtTelefoneChange(Sender: TObject);
begin
  if Length(edtTelefone.Text) >= 10 then
    edtTelefone.Text := FormatarTelefone(edtTelefone.Text);
end;

function TfrmProfissionaisRegistrar.FormatarTelefone(sTelefone: string): string;
var
  sPattern: string;
begin
  sPattern := IfThen(sTelefone.Length = 11, '(\d{2})(\d{5})(\d{4})', '(\d{2})(\d{4})(\d{4})');

  Result := TRegEx.Replace(sTelefone, sPattern, '($1) $2-$3');
end;

end.
