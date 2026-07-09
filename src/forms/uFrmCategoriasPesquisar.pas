unit uFrmCategoriasPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmConexao, uCategoriaService, uCategoria,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrmCategoriasPesquisar = class(TForm)
    tbCategoriasPesquisar: TToolBar;
    btnVoltar: TToolButton;
    btnPesquisar: TToolButton;
    btnConfirmar: TToolButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
end;

end.
