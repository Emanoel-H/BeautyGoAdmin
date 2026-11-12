unit uFrmProfissionais;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls, System.Math,
  Vcl.ExtCtrls, System.RegularExpressions, System.StrUtils, uProfissional, uProfissionalService,
  uDmConexao, Vcl.NumberBox, System.Net.HttpClient, System.JSON, System.NetEncoding;

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
    btnServicos: TToolButton;
    cbxMostrarSenha: TCheckBox;
    edtEndereco: TEdit;
    Label2: TLabel;
    btnLocalizar: TButton;
    edtLatitude: TEdit;
    lblLatitude: TLabel;
    Label3: TLabel;
    edtLongitude: TEdit;
    nbRaioAtendimento: TNumberBox;
    lblRaioAtendimento: TLabel;
    procedure edtTelefoneChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure cbxMostrarSenhaClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnLocalizarClick(Sender: TObject);
  private
    { Private declarations }
    Profissional: TProfissional;
    Service: TProfissionalService;
    function FormatarTelefone(sTelefone: string): string;
    procedure estadoInicial;
    procedure estadoEdicao;
    procedure estadoPesquisar;
    procedure limparCampos;
    procedure setEndereco(dLat, dLng: double);
  public
    { Public declarations }
    procedure recebeProfissional(AProfissional: TProfissional);
  end;

var
  frmProfissionaisRegistrar: TfrmProfissionaisRegistrar;

implementation

uses
  uFrmProfissionaisPesquisar;

{$R *.dfm}

{ TfrmProfissionaisRegistrar }

procedure TfrmProfissionaisRegistrar.btnAtualizarClick(Sender: TObject);
begin
  estadoEdicao;
end;

procedure TfrmProfissionaisRegistrar.btnCancelarClick(Sender: TObject);
begin
  estadoInicial;
  limparCampos;
end;

procedure TfrmProfissionaisRegistrar.btnConfirmarClick(Sender: TObject);
begin
  Profissional.Nome     := trim(edtNome.Text);
  Profissional.Bio      := trim(mmBio.Text);
  Profissional.Email    := trim(edtEmail.Text);
  Profissional.Telefone := trim(edtTelefone.Text);

  try
    Service.Salvar(Profissional);
    estadoInicial;
  except
    on E: Exception do
    begin
      Application.MessageBox(PChar(E.Message), 'Atenção!', MB_OK + MB_ICONWARNING)
    end;
  end;
end;

procedure TfrmProfissionaisRegistrar.btnDeletarClick(Sender: TObject);
begin
  if MessageBox(Handle, PChar('Tem certeza que deseja excluir esse Profissional?'), PChar('Atenção!'), MB_YESNO + MB_ICONQUESTION) = IDYES then
  begin
    try
      Service.Excluir(Profissional);
      estadoInicial;
      limparCampos;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar(E.Message), 'Atenção!', MB_OK + MB_ICONWARNING)
      end;
    end;
  end;
end;

procedure TfrmProfissionaisRegistrar.btnInserirClick(Sender: TObject);
begin
  limparCampos;
  estadoEdicao;
end;

procedure TfrmProfissionaisRegistrar.btnLocalizarClick(Sender: TObject);
var
  Http: THttpClient;
  Response: IHTTPResponse;
  JSON: TJSONArray;
  sURL, sLat, sLng: string;
begin
  if Trim(edtEndereco.Text) = '' then
  begin
    Application.MessageBox('Digite um endereço para localizar.', 'Atenção!', MB_OK + MB_ICONWARNING);
    Exit;
  end;

  Http := THTTPClient.Create;
  try
    try
      Http.CustomHeaders['User-Agent'] := 'BeautyGoAdmin/1.0';

      sUrl := 'https://nominatim.openstreetmap.org/search?q=' +
              TNetEncoding.URL.Encode(Trim(edtEndereco.Text)) +
              '&format=json&limit=1';

      Response := Http.Get(sURL);
      if Response.StatusCode = 200 then
      begin
        JSON := TJSONObject.ParseJSONValue(Response.ContentAsString()) as TJSONArray;
        try
          if (JSON <> nil) and (JSON.Count > 0) then
          begin
            sLat := JSON.Items[0].GetValue<string>('lat');
            sLng := JSON.Items[0].GetValue<string>('lon');

            edtLatitude.Text  := sLat;
            edtLongitude.Text := sLng;

            Profissional.Latitude  := StrToFloat(sLat.Replace('.', FormatSettings.DecimalSeparator));
            Profissional.Longitude := StrToFloat(sLng.Replace('.', FormatSettings.DecimalSeparator));
          end
          else
            Application.MessageBox('Endereço não encontrado. Tente ser mais específico.', 'Atenção', MB_OK + MB_ICONWARNING);
        finally
          JSON.Free;
        end;
      end;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('Erro ao buscar localização: ' + E.Message), 'Atenção!', MB_OK + MB_ICONWARNING);
      end;
    end;
  finally
    Http.Free;
  end;
end;

procedure TfrmProfissionaisRegistrar.btnPesquisarClick(Sender: TObject);
begin
  if frmProfissionaisPesquisar = nil then
  begin
    frmProfissionaisPesquisar := TFrmProfissionaisPesquisar.Create(Self);
    frmProfissionaisPesquisar.ShowModal;

    if Profissional.Id <> 0 then
      estadoPesquisar;
  end;
end;

procedure TfrmProfissionaisRegistrar.btnVoltarClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmProfissionaisRegistrar.cbxMostrarSenhaClick(Sender: TObject);
begin
  if cbxMostrarSenha.Checked then
    edtSenha.PasswordChar := #0
  else
    edtSenha.PasswordChar := '*';
end;

procedure TfrmProfissionaisRegistrar.edtTelefoneChange(Sender: TObject);
begin
  if Length(edtTelefone.Text) >= 10 then
    edtTelefone.Text := FormatarTelefone(edtTelefone.Text);
end;

procedure TfrmProfissionaisRegistrar.estadoEdicao;
begin
  btnAtualizar.Enabled := false;
  btnInserir.Enabled   := false;
  btnDeletar.Enabled   := false;
  btnPesquisar.Enabled := false;
  btnCancelar.Enabled  := true;
  btnConfirmar.Enabled := true;
  pnPrincipal.Enabled  := true;

  edtNome.SetFocus;
end;

procedure TfrmProfissionaisRegistrar.estadoInicial;
begin
  btnAtualizar.Enabled := false;
  btnInserir.Enabled   := true;
  btnDeletar.Enabled   := false;
  btnPesquisar.Enabled := true;
  btnCancelar.Enabled  := false;
  btnConfirmar.Enabled := false;
  pnPrincipal.Enabled  := false;
end;

procedure TfrmProfissionaisRegistrar.estadoPesquisar;
begin
  btnAtualizar.Enabled := true;
  btnInserir.Enabled   := false;
  btnDeletar.Enabled   := true;
  btnPesquisar.Enabled := false;
  btnCancelar.Enabled  := true;
  btnConfirmar.Enabled := false;
  pnPrincipal.Enabled  := false;
end;

function TfrmProfissionaisRegistrar.FormatarTelefone(sTelefone: string): string;
var
  sPattern: string;
begin
  sPattern := IfThen(sTelefone.Length = 11, '(\d{2})(\d{5})(\d{4})', '(\d{2})(\d{4})(\d{4})');

  Result := TRegEx.Replace(sTelefone, sPattern, '($1) $2-$3');
end;

procedure TfrmProfissionaisRegistrar.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if Parent <> nil then
  begin
    Action := caNone;
    Exit;
  end;

  try
    Profissional.Free;
    Service.Free;
  finally
    Action                    := caFree;
    frmProfissionaisRegistrar := nil;
  end;
end;

procedure TfrmProfissionaisRegistrar.FormCreate(Sender: TObject);
begin
  Profissional := TProfissional.Create;
  Service      := TProfissionalService.Create(dmConexao.FDConnection);
end;

procedure TfrmProfissionaisRegistrar.FormShow(Sender: TObject);
begin
  btnVoltar.Visible := Parent = nil;
  estadoInicial;
end;

procedure TfrmProfissionaisRegistrar.setEndereco(dLat, dLng: double);
var
  Http: THttpClient;
  Response: IHTTPResponse;
  JSON: TJSONArray;
  sURL, sEndereco: string;
begin
  Http := THTTPClient.Create;
  try
    try
      Http.CustomHeaders['User-Agent'] := 'BeautyGoAdmin/1.0';

      sUrl := 'http://nominatim.openstreetmap.org/reverse?&format=json'+
              '&lat='+FloatToStr(dLat, TFormatSettings.Invariant)+
              '&lon='+FloatToStr(dLng, TFormatSettings.Invariant);

      Response := Http.Get(sURL);
      if Response.StatusCode = 200 then
      begin
        JSON := TJSONObject.ParseJSONValue(Response.ContentAsString()) as TJSONArray;
        try
          if (JSON <> nil) and (JSON.Count > 0) then
          begin
            sEndereco := JSON.Items[0].GetValue<string>('display_name');

            edtEndereco.Text := sEndereco;
          end
          else
            Application.MessageBox('Endereço não encontrado conforme as coordenadas.', 'Atenção', MB_OK + MB_ICONWARNING);
        finally
          JSON.Free;
        end;
      end;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('Erro ao buscar endereço: ' + E.Message), 'Atenção!', MB_OK + MB_ICONWARNING);
      end;
    end;
  finally
    Http.Free;
  end;
end;

procedure TfrmProfissionaisRegistrar.limparCampos;
begin
  Profissional.Id                := 0;
  Profissional.Nome              := '';
  Profissional.Bio               := '';
  Profissional.Telefone          := '';
  Profissional.Email             := '';
  Profissional.Senha             := '';
  Profissional.Codigo            := '';
  Profissional.RaioAtendimentoKm := 0;
  Profissional.Latitude          := 0;
  Profissional.Longitude         := 0;

  edtNome.Text            := '';
  edtEmail.Text           := '';
  edtSenha.Text           := '';
  edtTelefone.Text        := '';
  edtEndereco.Text        := '';
  edtLatitude.Text        := '';
  edtLongitude.Text       := '';
  nbRaioAtendimento.Value := 0;

  mmBio.Clear;
end;

procedure TfrmProfissionaisRegistrar.recebeProfissional(
  AProfissional: TProfissional);
begin
  Profissional.Id        := AProfissional.Id;
  Profissional.Nome      := AProfissional.Nome;
  Profissional.Bio       := AProfissional.Bio;
  Profissional.Email     := AProfissional.Email;
  Profissional.Telefone  := AProfissional.Telefone;
  Profissional.Senha     := AProfissional.Senha;
  Profissional.Latitude  := AProfissional.Latitude;
  Profissional.Longitude := AProfissional.Longitude;

  edtNome.Text      := Profissional.Nome;
  edtEmail.Text     := Profissional.Email;
  edtSenha.Text     := Profissional.Senha;
  edtTelefone.Text  := Profissional.Telefone;
  mmBio.Text        := Profissional.Bio;
  edtLongitude.Text := FloatToStr(Profissional.Longitude).Replace('.', FormatSettings.DecimalSeparator);
  edtLatitude.Text  := FloatToStr(Profissional.Latitude).Replace('.', FormatSettings.DecimalSeparator);
  setEndereco(Profissional.Latitude, Profissional.Longitude);
end;

end.
