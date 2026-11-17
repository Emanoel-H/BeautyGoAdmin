unit uFrmServicosPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.NumberBox,
  Vcl.Buttons, uServicoOferecido, uProfissionalService, uDmConexao, uCategoriaService,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, uCategoria,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmServicosPesquisar = class(TForm)
    dbgServicos: TDBGrid;
    pnMenu: TPanel;
    lblCodigo: TLabel;
    edtCodigo: TEdit;
    pnRodape: TPanel;
    pnRegistros: TPanel;
    lblRegistros: TLabel;
    lblQtdeRegistros: TLabel;
    tbPesquisar: TToolBar;
    btnVoltar: TToolButton;
    btnPesquisar: TToolButton;
    btnConfirmar: TToolButton;
    nbPreco: TNumberBox;
    lblCategorias: TLabel;
    lblPreco: TLabel;
    sbCategoriasPesquisar: TSpeedButton;
    btnInserir: TToolButton;
    btnAtualizar: TToolButton;
    btnDeletar: TToolButton;
    btnCancelar: TToolButton;
    dblCategorias: TDBLookupComboBox;
    fdqServicos: TFDQuery;
    dsServicos: TDataSource;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ServicoOferecido: TServicoOferecido;
    Service: TProfissionalService;
    CategoriaService: TCategoriaService;
    dsCategorias: TDataSource;
    Categoria: TCategoria;
    procedure estadoInicial;
  public
    { Public declarations }
  end;

var
  frmServicosPesquisar: TfrmServicosPesquisar;

implementation

{$R *.dfm}

procedure TfrmServicosPesquisar.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmServicosPesquisar.estadoInicial;
begin
  btnAtualizar.Enabled := true;
  btnInserir.Enabled   := true;
  btnDeletar.Enabled   := true;
  btnPesquisar.Enabled := true;
  btnCancelar.Enabled  := false;
  btnConfirmar.Enabled := false;
end;

procedure TfrmServicosPesquisar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    ServicoOferecido.Free;
    Service.Free;
    CategoriaService.Free;
  finally
    Action               := caFree;
    frmServicosPesquisar := nil;
  end;
end;

procedure TfrmServicosPesquisar.FormCreate(Sender: TObject);
begin
  ServicoOferecido := TServicoOferecido.Create;
  Service          := TProfissionalService.Create(dmConexao.FDConnection);
  CategoriaService := TCategoriaService.Create(dmConexao.FDConnection);
  dsCategorias     := TDataSource.Create(nil);
  Categoria        := TCategoria.Create;
end;

procedure TfrmServicosPesquisar.FormShow(Sender: TObject);
begin
  dsCategorias.DataSet     := CategoriaService.Listar(Categoria);
  dblCategorias.ListSource := dsCategorias;
  estadoInicial;
end;

end.
