unit uFrmProfissionaisPesquisar;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, uFrmProfissionais,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, uDmConexao, uProfissionalService, uProfissional,
  System.RegularExpressions, System.StrUtils;

type
  TfrmProfissionaisPesquisar = class(TForm)
    dbgProfissionais: TDBGrid;
    pnMenu: TPanel;
    lblCodigo: TLabel;
    lblNome: TLabel;
    edtCodigo: TEdit;
    edtNome: TEdit;
    pnRodape: TPanel;
    pnRegistros: TPanel;
    lblRegistros: TLabel;
    lblQtdeRegistros: TLabel;
    tbPesquisar: TToolBar;
    btnVoltar: TToolButton;
    btnPesquisar: TToolButton;
    btnConfirmar: TToolButton;
    fdqProfissionais: TFDQuery;
    dsProfissionais: TDataSource;
    fdqProfissionaisid: TLargeintField;
    fdqProfissionaiscodigo: TWideStringField;
    fdqProfissionaisnome: TWideStringField;
    fdqProfissionaisbio: TWideStringField;
    fdqProfissionaisemail: TWideStringField;
    fdqProfissionaistelefone: TWideStringField;
    fdqProfissionaisraio: TBCDField;
    fdqProfissionaislatitude: TFloatField;
    fdqProfissionaislongitude: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure dbgProfissionaisDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure fdqProfissionaistelefoneGetText(Sender: TField; var Text: string;
      DisplayText: Boolean);
    procedure edtCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtNomeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Profissional: TProfissional;
    Service: TProfissionalService;
    function FormatarTelefone(sTelefone: string): string;
  public
    { Public declarations }
  end;

var
  frmProfissionaisPesquisar: TfrmProfissionaisPesquisar;

implementation

{$R *.dfm}

procedure TfrmProfissionaisPesquisar.btnConfirmarClick(Sender: TObject);
begin
  if (frmProfissionaisRegistrar <> nil) and not (fdqProfissionais.IsEmpty) then
  begin
    Profissional.Id       := dbgProfissionais.DataSource.DataSet.FieldByName('id').AsInteger;
    Profissional.Nome     := dbgProfissionais.DataSource.DataSet.FieldByName('nome').AsString;
    Profissional.Bio      := dbgProfissionais.DataSource.DataSet.FieldByName('bio').AsString;
    Profissional.Email    := dbgProfissionais.DataSource.DataSet.FieldByName('email').AsString;
    Profissional.Senha    := dbgProfissionais.DataSource.DataSet.FieldByName('senha').AsString;
    Profissional.Telefone := dbgProfissionais.DataSource.DataSet.FieldByName('telefone').AsString;

    frmProfissionaisRegistrar.recebeProfissional(Profissional);
    Close;
  end;
end;

procedure TfrmProfissionaisPesquisar.btnPesquisarClick(Sender: TObject);
begin
  Profissional.Nome   := edtNome.Text;
  Profissional.Codigo := edtCodigo.Text;

  fdqProfissionais    := Service.Listar(Profissional);

  if fdqProfissionais.IsEmpty then
    Application.MessageBox('Não há registros na consulta!', 'Atenção!', MB_OK + MB_ICONWARNING);

  dsProfissionais.DataSet  := fdqProfissionais;
  lblQtdeRegistros.Caption := fdqProfissionais.RecordCount.ToString;
end;

procedure TfrmProfissionaisPesquisar.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProfissionaisPesquisar.dbgProfissionaisDrawColumnCell(
  Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if gdSelected in State then
  begin
    dbgProfissionais.Canvas.Brush.Color := clNavy;
    dbgProfissionais.Canvas.Font.Color := clWhite;
  end

  else if dbgProfissionais.DataSource.DataSet.RecNo mod 2 = 0 then
  begin
    dbgProfissionais.Canvas.Brush.Color := $00673AB7;
  end;
  dbgProfissionais.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmProfissionaisPesquisar.edtCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    btnPesquisar.Click;
end;

procedure TfrmProfissionaisPesquisar.edtNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    btnPesquisar.Click;
end;

procedure TfrmProfissionaisPesquisar.fdqProfissionaistelefoneGetText(
  Sender: TField; var Text: string; DisplayText: Boolean);
begin
  if not Sender.IsNull then
    Text := FormatarTelefone(Sender.AsString)
  else
    Text := '';
end;

function TfrmProfissionaisPesquisar.FormatarTelefone(sTelefone: string): string;
var
  sPattern: string;
begin
  sPattern := IfThen(sTelefone.Length = 11, '(\d{2})(\d{5})(\d{4})', '(\d{2})(\d{4})(\d{4})');

  Result := TRegEx.Replace(sTelefone, sPattern, '($1) $2-$3');
end;

procedure TfrmProfissionaisPesquisar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  try
    Profissional.Free;
    Service.Free;
  finally
    Action                    := caFree;
    frmProfissionaisPesquisar := nil;
  end;
end;

procedure TfrmProfissionaisPesquisar.FormCreate(Sender: TObject);
begin
  Profissional := TProfissional.Create;
  Service      := TProfissionalService.Create(dmConexao.FDConnection);
end;

procedure TfrmProfissionaisPesquisar.FormShow(Sender: TObject);
begin
  fdqProfissionais := Service.Listar(Profissional);

  if fdqProfissionais.IsEmpty then
    Application.MessageBox('Não há registros na consulta!', 'Atenção!', MB_OK + MB_ICONWARNING);

  dsProfissionais.DataSet  := fdqProfissionais;
  lblQtdeRegistros.Caption := fdqProfissionais.RecordCount.ToString;
end;

end.
