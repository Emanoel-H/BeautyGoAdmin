unit uFrmServicosPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.NumberBox,
  Vcl.Buttons, uServicoOferecido, uProfissionalService, uDmConexao;

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
    cbCategorias: TComboBox;
    procedure btnVoltarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    ServicoOferecido: TServicoOferecido;
    Service: TProfissionalService;
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
  btnAtualizar.Enabled := false;
  btnInserir.Enabled   := true;
  btnDeletar.Enabled   := false;
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
  finally
    Action               := caFree;
    frmServicosPesquisar := nil;
  end;
end;

procedure TfrmServicosPesquisar.FormCreate(Sender: TObject);
begin
  ServicoOferecido := TServicoOferecido.Create;
  Service := TProfissionalService.Create(dmConexao.FDConnection);
end;

end.
