unit uProfissionalDAO;

interface
uses
  System.SysUtils, IRepositorio, uProfissional, uServicoOferecido, System.Generics.Collections, uDmConexao,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param, FireDAC.Phys.PG, DB,
  Classes;
type
  TProfissionalDAO = class(TInterfacedObject, IRepositorio.Repositorio<TProfissional>)
    private
      FConexao: TFDConnection;
    public
      constructor Create(AConexao: TFDConnection);

    procedure Inserir(AEntidade: TProfissional);
    procedure Atualizar(AEntidade: TProfissional);
    procedure Deletar(AEntidade: TProfissional);
    function BuscarPorCodigo(ACodigo: string): TProfissional;
    function Listar(AEntidade: TProfissional): TFDQuery;
    function Existe(AEntidade: TProfissional): boolean;

    procedure InserirServico(AServico: TServicoOferecido);
    procedure DeletarServico(AServicoId: Int64);
    function ListarServicos(AProfissionalId: Int64): TFDQuery;


  end;

implementation

{ TProfissionalDAO }

procedure TProfissionalDAO.Atualizar(AEntidade: TProfissional);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'UPDATE profissionais SET                           '+
            'nome = :nome,                                      '+
            'codigo = :codigo                                   '+
            'email = :email                                     '+
            'telefone = :telefone                               '+
            'senha = :senha                                     '+
            'raio_atendimento_km = :raio                        '+
            'localizacao = ST_MakePoint(:lng, :lat)::geography) '+
            'WHERE id = :id                                     ';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ParamByName('nome').AsString     := AEntidade.Nome;
    fSet.ParamByName('codigo').AsString   := AEntidade.Codigo;
    fSet.ParamByName('email').AsString    := AEntidade.Email;
    fSet.ParamByName('telefone').AsString := AEntidade.Telefone;
    fSet.ParamByName('senha').AsString    := AEntidade.Senha;
    fSet.ParamByName('raio').AsFloat      := AEntidade.RaioAtendimentoKm;
    fSet.ParamByName('lng').AsFloat       := AEntidade.Longitude;
    fSet.ParamByName('lat').AsFloat       := AEntidade.Latitude;
    fSet.ParamByName('id').AsInteger      := AEntidade.Id;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;
end;

function TProfissionalDAO.BuscarPorCodigo(ACodigo: string): TProfissional;
var
  sSQL: string;
  fGet: TFDQuery;
  Profissional: TProfissional;
begin
  fGet := TFDQuery.Create(nil);
  try
    fGet.Connection := FConexao;

    sSQL := 'SELECT                                   '+
            'id,                                      '+
            'code as codigo,                          '+
            'nome,                                    '+
            'email,                                   '+
            'telefone,                                '+
            'senha,                                   '+
            'raio_atendimento_km as raio,             '+
            'ST_Y(localizacao::geometry) AS latitude, '+
            'ST_X(localizacao::geometry) AS longitude '+
            'FROM profissionais                       '+
            'WHERE code = :codigo                     ';

    fGet.Close;
    fGet.SQL.Clear;
    fGet.SQL.Text := sSQL;
    fGet.ParamByName('codigo').AsString := ACodigo;
    fGet.Open;

    if not fGet.IsEmpty then
    begin
      Profissional                   := TProfissional.Create;
      Profissional.Id                := fGet.FieldByName('id').AsInteger;
      Profissional.Nome              := fGet.FieldByName('nome').AsString;
      Profissional.Codigo            := fGet.FieldByName('codigo').AsString;
      Profissional.Email             := fGet.FieldByName('email').AsString;
      Profissional.Telefone          := fGet.FieldByName('telefone').AsString;
      Profissional.Senha             := fGet.FieldByName('senha').AsString;
      Profissional.RaioAtendimentoKm := fGet.FieldByName('raio').AsFloat;
      Profissional.Latitude          := fGet.FieldByName('latitude').AsFloat;
      Profissional.Longitude         := fGet.FieldByName('longitude').AsFloat;

      Result := Profissional;
    end;

  finally
    fGet.Close;
    fGet.Free;
  end;
end;

constructor TProfissionalDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

procedure TProfissionalDAO.Deletar(AEntidade: TProfissional);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'DELETE FROM profissionais WHERE id = :id ';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ParamByName('id').AsInteger := AEntidade.Id;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;
end;

procedure TProfissionalDAO.DeletarServico(AServicoId: Int64);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'DELETE FROM servicos_oferecidos WHERE id = :id ';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ParamByName('id').AsInteger := AServicoId.Id;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;
end;

function TProfissionalDAO.Existe(AEntidade: TProfissional): boolean;
var
  sSQL: string;
  fGet: TFDQuery;
begin
  fGet := TFDQuery.Create(nil);
  try
    fGet.Connection := FConexao;

    sSQL :=
    'SELECT id FROM servicos_oferecidos WHERE profissional_id = :profissional_id ';

    fGet.Close;
    fGet.SQL.Clear;
    fGet.SQL.Text := sSQL;
    fGet.ParamByName('profissional_id').AsInteger := AEntidade.Id;
    fGet.Open;

    Result := not (fGet.IsEmpty);
  finally
    fGet.Close;
    fGet.Free;
  end;
end;

procedure TProfissionalDAO.Inserir(AEntidade: TProfissional);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'INSERT INTO profissionais '+
            '(nome, email, telefone, senha, raio_atendimento_km, localizacao)   '+
            'VALUES(:nome, :email, :telefone, :senha, :raio, ST_MakePoint(:lng, :lat)::geography))';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ParamByName('nome').AsString     := AEntidade.Nome;
    fSet.ParamByName('email').AsString    := AEntidade.Email;
    fSet.ParamByName('telefone').AsString := AEntidade.Telefone;
    fSet.ParamByName('senha').AsString    := AEntidade.Senha;
    fSet.ParamByName('raio').AsFloat      := AEntidade.RaioAtendimentoKm;
    fSet.ParamByName('lng').AsFloat       := AEntidade.Longitude;
    fSet.ParamByName('lat').AsFloat       := AEntidade.Latitude;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;
end;

procedure TProfissionalDAO.InserirServico(AServico: TServicoOferecido);
begin

end;

function TProfissionalDAO.Listar(AEntidade: TProfissional): TFDQuery;
begin

end;

function TProfissionalDAO.ListarServicos(AProfissionalId: Int64): TFDQuery;
begin

end;

end.
