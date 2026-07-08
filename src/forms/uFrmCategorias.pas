unit uFrmCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, uDmConexao, uCategoriaService;

type
  TfrmCategoriasRegistrar = class(TForm)
    tbCategorias: TToolBar;
    btnVoltar: TToolButton;
    btnCancel: TToolButton;
    btnDelete: TToolButton;
    btnUpdate: TToolButton;
    btnAdd: TToolButton;
    btnSearch: TToolButton;
    btnConfirm: TToolButton;
    pnMain: TPanel;
    lblName: TLabel;
    edtName: TEdit;
    mmDescricao: TMemo;
    lblDescricao: TLabel;
  private
    Service: CategoriaService;
    Conexao: TDmConexao;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCategoriasRegistrar: TfrmCategoriasRegistrar;

implementation

{$R *.dfm}

end.
