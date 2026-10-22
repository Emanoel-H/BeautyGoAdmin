unit uFrmProfissionais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TfrmProfissionaisRegistrar = class(TForm)
    pnPrincipal: TPanel;
    lblName: TLabel;
    lblBio: TLabel;
    edtNome: TEdit;
    mmBio: TMemo;
    tbCategorias: TToolBar;
    btnVoltar: TToolButton;
    btnCancelar: TToolButton;
    btnDeletar: TToolButton;
    btnAtualizar: TToolButton;
    btnInserir: TToolButton;
    btnPesquisar: TToolButton;
    btnConfirmar: TToolButton;
    lblEmail: TLabel;
    edtEmail: TEdit;
    lblSenha: TLabel;
    edtSenha: TEdit;
    Label1: TLabel;
    edtTelefone: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProfissionaisRegistrar: TfrmProfissionaisRegistrar;

implementation

{$R *.dfm}

end.
