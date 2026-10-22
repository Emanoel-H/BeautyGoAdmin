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
    btnServicos: TToolButton;
    cbxMostrarSenha: TCheckBox;
    procedure edtTelefoneChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
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
    procedure recebeProfissional(AProfissional: TProfissional);
  end;

var
  frmProfissionaisRegistrar: TfrmProfissionaisRegistrar;

implementation

{$R *.dfm}

{ TfrmProfissionaisRegistrar }

procedure TfrmProfissionaisRegistrar.btnAtualizarClick(Sender: TObject);
begin
  estadoEdicao;
end;

procedure TfrmProfissionaisRegistrar.btnCancelarClick(Sender: TObject);
begin
  estadoInicial;
  limparCampos;
end;

procedure TfrmProfissionaisRegistrar.btnConfirmarClick(Sender: TObject);
begin
  Profissional.Nome     := trim(edtNome.Text);
  Profissional.Bio      := trim(mmBio.Text);
  Profissional.Email    := trim(edtEmail.Text);
  Profissional.Telefone := trim(edtTelefone.Text);

  try
    Service.Salvar(Profissional);
    estadoInicial;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), 'Atenção!', MB_OK + MB_ICONWARNING)
    end;
  end;
end;

procedure TfrmProfissionaisRegistrar.btnDeletarClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar('Tem certeza que deseja excluir esse Profissional?'), PChar('Atenção!'), MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    try
      Service.Excluir(Profissional);
      estadoInicial;
      limparCampos;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar(E.Message), 'Atenção!', MB_OK + MB_ICONWARNING)
      end;
    end;
  end;
end;

procedure TfrmProfissionaisRegistrar.btnInserirClick(Sender: TObject);
begin
  limparCampos;
  estadoEdicao;
end;

procedure TfrmProfissionaisRegistrar.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProfissionaisRegistrar.edtTelefoneChange(Sender: TObject);
begin
  if Length(edtTelefone.Text) >= 10 then
    edtTelefone.Text := FormatarTelefone(edtTelefone.Text);
end;

procedure TfrmProfissionaisRegistrar.estadoEdicao;
begin
  btnAtualizar.Enabled := false;
  btnInserir.Enabled   := false;
  btnDeletar.Enabled   := false;
  btnPesquisar.Enabled := false;
  btnCancelar.Enabled  := true;
  btnConfirmar.Enabled := true;
  pnPrincipal.Enabled  := true;

  edtNome.SetFocus;
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
  btnAtualizar.Enabled := true;
  btnInserir.Enabled   := false;
  btnDeletar.Enabled   := true;
  btnPesquisar.Enabled := false;
  btnCancelar.Enabled  := true;
  btnConfirmar.Enabled := false;
  pnPrincipal.Enabled  := false;
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
  estadoInicial;
end;

procedure TfrmProfissionaisRegistrar.limparCampos;
begin
  Profissional.Id                := 0;
  Profissional.Nome              := '';
  Profissional.Bio               := '';
  Profissional.Telefone          := '';
  Profissional.Email             := '';
  Profissional.Senha             := '';
  Profissional.Codigo            := '';
  Profissional.RaioAtendimentoKm := 0;
  Profissional.Latitude          := 0;
  Profissional.Longitude         := 0;

  edtNome.Text     := '';
  edtEmail.Text    := '';
  edtSenha.Text    := '';
  edtTelefone.Text := '';

  mmBio.Clear;
end;

procedure TfrmProfissionaisRegistrar.recebeProfissional(
  AProfissional: TProfissional);
begin
  Profissional.Id       := AProfissional.Id;
  Profissional.Nome     := AProfissional.Nome;
  Profissional.Bio      := AProfissional.Bio;
  Profissional.Email    := AProfissional.Email;
  Profissional.Telefone := AProfissional.Telefone;
  Profissional.Senha    := AProfissional.Senha;

  edtNome.Text     := Profissional.Nome;
  edtEmail.Text    := Profissional.Email;
  edtSenha.Text    := Profissional.Senha;
  edtTelefone.Text := Profissional.Telefone;
  mmBio.Text       := Profissional.Bio;
end;

end.
