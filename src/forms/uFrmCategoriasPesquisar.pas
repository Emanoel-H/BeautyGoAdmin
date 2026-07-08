unit uFrmCategoriasPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmConexao, uCategoriaService, uCategoria;

type
  TfrmCategoriasPesquisar = class(TForm)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
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

end.
