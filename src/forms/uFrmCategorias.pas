unit uFrmCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, uDmConexao, uCategoriaService, uCategoria;

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
    edtName: TEdit;
    mmDescricao: TMemo;
    lblDescricao: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    Service: CategoriaService;
    Categoria: TuCategoria;
    procedure estadoInicial;
  public
    bInserir: boolean;
  end;

var
  frmCategoriasRegistrar: TfrmCategoriasRegistrar;

implementation

{$R *.dfm}

procedure TfrmCategoriasRegistrar.btnVoltarClick(Sender: TObject);
begin
  Close;
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

  bInserir := false;
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

end.
