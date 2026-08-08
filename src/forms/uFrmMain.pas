unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, uFrmCategorias;

type
  TfrmMain = class(TForm)
    pcMain: TPageControl;
    Categorias: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try

  finally
    Action  := caFree;
    frmMain := nil;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var
  FrmCategoria: TfrmCategoriasRegistrar;
begin
  FrmCategoria             := TfrmCategoriasRegistrar.Create(Self);
  FrmCategoria.Parent      := Categorias;
  FrmCategoria.Align       := alClient;
  FrmCategoria.BorderStyle := bsNone;
  FrmCategoria.Show;
end;

end.
