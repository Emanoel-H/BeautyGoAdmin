unit uFrmCategoriasPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uDmConexao, uCategoriaService, uCategoria;

type
  TfrmCategoriasPesquisar = class(TForm)
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

end.
