unit uFrmCategoriasPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmConexao, uCategoriaService, uCategoria,
  Vcl.ComCtrls, Vcl.ToolWin, Data.DB, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TfrmCategoriasPesquisar = class(TForm)
    tbCategoriasPesquisar: TToolBar;
    btnVoltar: TToolButton;
    btnPesquisar: TToolButton;
    btnConfirmar: TToolButton;
    dbgCategorias: TDBGrid;
    pnRodape: TPanel;
    pnRegistros: TPanel;
    lblRegistros: TLabel;
    lblQtdeRegistros: TLabel;
    pnMenu: TPanel;
    lblCodigo: TLabel;
    lblNome: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    fdqCategorias: TFDQuery;
    dsCategorias: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
  private
    Categoria: TuCategoria;
    Service: CategoriaService;
  public
    { Public declarations }
  end;

var
  frmCategoriasPesquisar: TfrmCategoriasPesquisar;

implementation

{$R *.dfm}

procedure TfrmCategoriasPesquisar.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCategoriasPesquisar.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13]) then
  begin
    Key := #0;
  end;
end;

procedure TfrmCategoriasPesquisar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    Categoria.Free;
    Service.Free;
  finally
    Action                 := caFree;
    frmCategoriasPesquisar := nil;
  end;
end;

procedure TfrmCategoriasPesquisar.FormCreate(Sender: TObject);
begin
  Categoria := TuCategoria.Create;
  Service   := CategoriaService.Create(dmConexao.FDConnection);

  dbgCategorias.Color           := clBlack;
  dbgCategorias.FixedColor      := $00202020;
  dbgCategorias.Font.Color      := clWhite;
  dbgCategorias.TitleFont.Color := clWhite;
  dbgCategorias.TitleFont.Style := [fsBold];
  dbgCategorias.DrawingStyle    := gdsClassic;
  dbgCategorias.ParentColor     := False;
end;

procedure TfrmCategoriasPesquisar.FormShow(Sender: TObject);
begin
  fdqCategorias            := Service.Listar(Categoria);
  dsCategorias.DataSet     := fdqCategorias;
  lblQtdeRegistros.Caption := fdqCategorias.RecordCount.ToString;
end;

end.
