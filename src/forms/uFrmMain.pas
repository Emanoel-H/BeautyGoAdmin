unit uFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, uFrmCategorias, uFrmProfissionais;

type
  TfrmMain = class(TForm)
    pcMain: TPageControl;
    Categorias: TTabSheet;
    Profissionais: TTabSheet;
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
begin
  frmCategoriasRegistrar             := TfrmCategoriasRegistrar.Create(Self);
  frmCategoriasRegistrar.Parent      := Categorias;
  frmCategoriasRegistrar.Align       := alClient;
  frmCategoriasRegistrar.BorderStyle := bsNone;
  frmCategoriasRegistrar.Show;

  frmProfissionaisRegistrar             := TfrmProfissionaisRegistrar.Create(Self);
  frmProfissionaisRegistrar.Parent      := Profissionais;
  frmProfissionaisRegistrar.Align       := alClient;
  frmProfissionaisRegistrar.BorderStyle := bsNone;
  frmProfissionaisRegistrar.Show;
end;

end.
