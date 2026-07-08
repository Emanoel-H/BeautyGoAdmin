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
    procedure FormCreate(Sender: TObject);
  private
    Service: CategoriaService;
    Categoria: TuCategoria;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCategoriasRegistrar: TfrmCategoriasRegistrar;

implementation

{$R *.dfm}

procedure TfrmCategoriasRegistrar.FormCreate(Sender: TObject);
begin
  try

  finally

  end;
end;

end.
