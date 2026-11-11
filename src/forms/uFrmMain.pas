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
    procedure pcMainChange(Sender: TObject);
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

  if pcMain.TabIndex = 1 then
  begin
    frmMain.Height := 740;
    pcMain.Height  := 680;
  end;

  frmProfissionaisRegistrar.Show;
end;

procedure TfrmMain.pcMainChange(Sender: TObject);
begin
  if pcMain.TabIndex = 1 then
  begin
    frmMain.Height := 740;
    pcMain.Height  := 680;
  end
  else
  begin
    frmMain.Height := 592;
    pcMain.Height  := 532;
  end;
end;

end.
