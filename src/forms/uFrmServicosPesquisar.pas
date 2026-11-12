unit uFrmServicosPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TfrmServicosPesquisar = class(TForm)
    dbgProfissionais: TDBGrid;
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmServicosPesquisar: TfrmServicosPesquisar;

implementation

{$R *.dfm}

end.
