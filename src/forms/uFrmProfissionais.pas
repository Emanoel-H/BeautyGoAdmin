unit uFrmProfissionais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, System.Math,
  Vcl.ExtCtrls, System.RegularExpressions, System.StrUtils, uProfissional, uProfissionalService,
  uDmConexao;

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
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Profissional: TProfissional;
    Service: TProfissionalService;
    function FormatarTelefone(sTelefone: string): string;
    procedure estadoInicial;
    procedure estadoEdicao;
    procedure estadoPesquisar;
    procedure limparCampos;
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

procedure TfrmProfissionaisRegistrar.estadoEdicao;
begin

end;

procedure TfrmProfissionaisRegistrar.estadoInicial;
begin
  btnAtualizar.Enabled := false;
  btnInserir.Enabled   := true;
  btnDeletar.Enabled   := false;
  btnPesquisar.Enabled := true;
  btnCancelar.Enabled  := false;
  btnConfirmar.Enabled := false;
  pnPrincipal.Enabled  := false;
end;

procedure TfrmProfissionaisRegistrar.estadoPesquisar;
begin

end;

function TfrmProfissionaisRegistrar.FormatarTelefone(sTelefone: string): string;
var
  sPattern: string;
begin
  sPattern := IfThen(sTelefone.Length = 11, '(\d{2})(\d{5})(\d{4})', '(\d{2})(\d{4})(\d{4})');

  Result := TRegEx.Replace(sTelefone, sPattern, '($1) $2-$3');
end;

procedure TfrmProfissionaisRegistrar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Parent <> nil then
  begin
    Action := caNone;
    Exit;
  end;

  try
    Profissional.Free;
    Service.Free;
  finally
    Action                    := caFree;
    frmProfissionaisRegistrar := nil;
  end;
end;

procedure TfrmProfissionaisRegistrar.FormCreate(Sender: TObject);
begin
  Profissional := TProfissional.Create;
  Service      := TProfissionalService.Create(dmConexao.FDConnection);
end;

procedure TfrmProfissionaisRegistrar.FormShow(Sender: TObject);
begin
  btnVoltar.Visible := Parent = nil;
end;

procedure TfrmProfissionaisRegistrar.limparCampos;
begin

end;

end.
