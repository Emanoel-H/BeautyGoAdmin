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
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbgServicosDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgServicosDblClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
  private
    { Private declarations }
    ServicoOferecido: TServicoOferecido;
    Service: TProfissionalService;
    CategoriaService: TCategoriaService;
    dsCategorias: TDataSource;
    Categoria: TCategoria;
    procedure estadoInicial;
    procedure limparCampos;
    procedure estadoEdicao;
  public
    { Public declarations }
  end;

var
  frmServicosPesquisar: TfrmServicosPesquisar;

implementation

{$R *.dfm}

procedure TfrmServicosPesquisar.btnInserirClick(Sender: TObject);
begin
  limparCampos;
  estadoEdicao;
end;

procedure TfrmServicosPesquisar.btnPesquisarClick(Sender: TObject);
begin
  ServicoOferecido.CategoriaId := StrToIntDef(VarToStr(dblCategorias.KeyValue), 0);
  ServicoOferecido.Codigo      := edtCodigo.Text;

  fdqServicos            := Service.Listar(ServicoOferecido);

  if fdqServicos.IsEmpty then
    Application.MessageBox('Não há registros na consulta!', 'Atenção!', MB_OK + MB_ICONWARNING);

  dsCategorias.DataSet     := fdqServicos;
  lblQtdeRegistros.Caption := fdqServicos.RecordCount.ToString;
end;

procedure TfrmServicosPesquisar.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmServicosPesquisar.dbgServicosDblClick(Sender: TObject);
begin
  ServicoOferecido.Id          := dbgServicos.DataSource.DataSet.FieldByName('id').AsInteger;
  ServicoOferecido.CategoriaId := dbgServicos.DataSource.DataSet.FieldByName('categoria_id').AsInteger;
  ServicoOferecido.Codigo      := dbgServicos.DataSource.DataSet.FieldByName('codigo').AsString;
  ServicoOferecido.Preco       := dbgServicos.DataSource.DataSet.FieldByName('preco').AsCurrency;

  edtCodigo.Text         := ServicoOferecido.Codigo;
  dblCategorias.KeyValue := ServicoOferecido.CategoriaId;
  nbPreco.ValueCurrency  := ServicoOferecido.Preco;
end;

procedure TfrmServicosPesquisar.dbgServicosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dbgServicos.Canvas.Brush.Color := clNavy;
    dbgServicos.Canvas.Font.Color := clWhite;
  end

    else if dbgServicos.DataSource.DataSet.RecNo mod 2 = 0 then
  begin
    dbgServicos.Canvas.Brush.Color := $00673AB7;
  end;
  dbgServicos.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmServicosPesquisar.estadoEdicao;
begin
  btnAtualizar.Enabled := false;
  btnInserir.Enabled   := false;
  btnDeletar.Enabled   := false;
  btnPesquisar.Enabled := false;
  btnCancelar.Enabled  := true;
  btnConfirmar.Enabled := true;
  nbPreco.Enabled      := true;
  edtCodigo.Enabled    := false;

  dblCategorias.SetFocus;
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
    dsCategorias.Free;
    Categoria.Free;
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

  dbgServicos.Color           := clBlack;
  dbgServicos.FixedColor      := $00202020;
  dbgServicos.Font.Color      := clWhite;
  dbgServicos.TitleFont.Color := clWhite;
  dbgServicos.TitleFont.Style := [fsBold];
  dbgServicos.DrawingStyle    := gdsClassic;
  dbgServicos.ParentColor     := False;
end;

procedure TfrmServicosPesquisar.FormShow(Sender: TObject);
begin
  dsCategorias.DataSet     := CategoriaService.Listar(Categoria);
  dblCategorias.ListSource := dsCategorias;
  estadoInicial;

  fdqServicos            := Service.Listar(ServicoOferecido);

  if fdqServicos.IsEmpty then
    Application.MessageBox('Não há registros na consulta!', 'Atenção!', MB_OK + MB_ICONWARNING);

  dsCategorias.DataSet     := fdqServicos;
  lblQtdeRegistros.Caption := fdqServicos.RecordCount.ToString;
end;

procedure TfrmServicosPesquisar.limparCampos;
begin
  ServicoOferecido.Id          := 0;
  ServicoOferecido.CategoriaId := 0;
  ServicoOferecido.Codigo      := '';
  ServicoOferecido.Preco       := 0;

  edtCodigo.Text         := '';
  dblCategorias.KeyValue := null;
  nbPreco.Value          := 0;
end;

end.
