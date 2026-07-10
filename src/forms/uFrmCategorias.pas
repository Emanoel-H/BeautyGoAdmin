unit uFrmCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, uDmConexao, uCategoriaService, uCategoria, uFrmCategoriasPesquisar;

type
  TfrmCategoriasRegistrar = class(TForm)
    tbCategorias: TToolBar;
    btnVoltar: TToolButton;
    btnCancelar: TToolButton;
    btnDeletar: TToolButton;
    btnAtualizar: TToolButton;
    btnInserir: TToolButton;
    btnPesquisar: TToolButton;
    btnConfirmar: TToolButton;
    pnPrincipal: TPanel;
    lblName: TLabel;
    edtNome: TEdit;
    mmDescricao: TMemo;
    lblDescricao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
  private
    Service: CategoriaService;
    Categoria: TuCategoria;
    procedure estadoInicial;
    procedure estadoEdicao;
    procedure estadoPesquisar;
    procedure limparCampos;
  public
    procedure recebeCategoria(ACategoria: TuCategoria);
  end;

var
  frmCategoriasRegistrar: TfrmCategoriasRegistrar;

implementation

{$R *.dfm}

procedure TfrmCategoriasRegistrar.btnAtualizarClick(Sender: TObject);
begin
  estadoEdicao;
end;

procedure TfrmCategoriasRegistrar.btnCancelarClick(Sender: TObject);
begin
  estadoInicial;
  limparCampos;
end;

procedure TfrmCategoriasRegistrar.btnConfirmarClick(Sender: TObject);
begin
  Categoria.Nome      := trim(edtNome.Text);
  Categoria.Descricao := trim(mmDescricao.Text);

  Service.Salvar(Categoria);
  estadoInicial;
end;

procedure TfrmCategoriasRegistrar.btnDeletarClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar('Tem certeza que deseja excluir essa categoria?'), PChar('Atenção!'), MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    Service.Excluir(Categoria);
    estadoInicial;
    limparCampos;
  end;
end;

procedure TfrmCategoriasRegistrar.btnInserirClick(Sender: TObject);
begin
  limparCampos;
  estadoEdicao;
end;

procedure TfrmCategoriasRegistrar.btnPesquisarClick(Sender: TObject);
begin
  if frmCategoriasPesquisar = nil then
  begin
    frmCategoriasPesquisar := TFrmCategoriasPesquisar.Create(Self);
    frmCategoriasPesquisar.ShowModal;

    if Categoria.Id <> 0 then
      estadoPesquisar;
  end;
end;

procedure TfrmCategoriasRegistrar.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCategoriasRegistrar.estadoEdicao;
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

procedure TfrmCategoriasRegistrar.estadoInicial;
begin
  btnAtualizar.Enabled := false;
  btnInserir.Enabled   := true;
  btnDeletar.Enabled   := false;
  btnPesquisar.Enabled := true;
  btnCancelar.Enabled  := false;
  btnConfirmar.Enabled := false;
  pnPrincipal.Enabled  := false;
end;

procedure TfrmCategoriasRegistrar.estadoPesquisar;
begin
  btnAtualizar.Enabled := true;
  btnInserir.Enabled   := false;
  btnDeletar.Enabled   := true;
  btnPesquisar.Enabled := false;
  btnCancelar.Enabled  := true;
  btnConfirmar.Enabled := false;
  pnPrincipal.Enabled  := false;
end;

procedure TfrmCategoriasRegistrar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    Categoria.Free;
    Service.Free;
  finally
    Action                 := caFree;
    frmCategoriasRegistrar := nil;
  end;
end;

procedure TfrmCategoriasRegistrar.FormCreate(Sender: TObject);
begin
  Service   := CategoriaService.Create(dmConexao.FDConnection);
  Categoria := TuCategoria.Create;
end;

procedure TfrmCategoriasRegistrar.FormShow(Sender: TObject);
begin
  estadoInicial;
end;

procedure TfrmCategoriasRegistrar.limparCampos;
begin
  Categoria.Id        := 0;
  Categoria.Nome      := '';
  Categoria.Descricao := '';

  edtNome.Text := '';
  mmDescricao.Clear;
end;

procedure TfrmCategoriasRegistrar.recebeCategoria(ACategoria: TuCategoria);
begin
  Categoria.Id        := ACategoria.Id;
  Categoria.Nome      := ACategoria.Nome;
  Categoria.Descricao := ACategoria.Descricao;

  edtNome.Text     := Categoria.Nome;
  mmDescricao.Text := Categoria.Descricao;
end;

end.
