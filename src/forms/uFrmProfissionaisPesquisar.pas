unit uFrmProfissionaisPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDmConexao;

type
  TfrmProfissionaisPesquisar = class(TForm)
    dbgCategorias: TDBGrid;
    pnMenu: TPanel;
    lblCodigo: TLabel;
    lblNome: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    pnRodape: TPanel;
    pnRegistros: TPanel;
    lblRegistros: TLabel;
    lblQtdeRegistros: TLabel;
    tbCategoriasPesquisar: TToolBar;
    btnVoltar: TToolButton;
    btnPesquisar: TToolButton;
    btnConfirmar: TToolButton;
    fdqProfissionais: TFDQuery;
    dsProfissionais: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProfissionaisPesquisar: TfrmProfissionaisPesquisar;

implementation

{$R *.dfm}

end.
