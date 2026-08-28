unit uProfissionalDAO;

interface
uses
  System.SysUtils, IRepositorio, uProfissional, uServicoOferecido, System.Generics.Collections, uDmConexao,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param, FireDAC.Phys.PG, DB,
  Classes, System.RegularExpressions;
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
            'email = :email,                                    '+
            'telefone = :telefone,                              '+
            'senha = :senha,                                    '+
            'raio_atendimento_km = :raio,                       '+
            'localizacao = ST_MakePoint(:lng, :lat)::geography) '+
            'WHERE id = :id                                     ';

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
    fSet.ParamByName('id').AsInteger := AServicoId;
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

    sSQL := 'INSERT INTO profissionais                                                             '+
            '(nome, email, telefone, senha, raio_atendimento_km, localizacao)                      '+
            'VALUES(:nome, :email, :telefone, :senha, :raio, ST_MakePoint(:lng, :lat)::geography)) ';

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
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'INSERT INTO servicos_oferecidos                 '+
            '(profissional_id, categoria_id, preco)          '+
            'VALUES(:profissional_id, :categoria_id, :preco) ';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ParamByName('profissional_id').AsInteger := AServico.ProfissionalId;
    fSet.ParamByName('categoria_id').AsInteger    := AServico.CategoriaId;
    fSet.ParamByName('preco').AsCurrency          := AServico.dPreco;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;
end;

function TProfissionalDAO.Listar(AEntidade: TProfissional): TFDQuery;
var
  sSQL: string;
  fGet: TFDQuery;
begin
  fGet := TFDQuery.Create(nil);
    try
      fGet.Connection := FConexao;

      sSQL := 'SELECT                  '+
              'id,                     '+
              'code as codigo,         '+
              'nome,                   '+
              'bio::VARCHAR(200),      '+
              'email,                  '+
              'telefone,               '+
              'localizacao             '+
              'FROM profissionais      '+
              'WHERE 1=1               ';

      if (AEntidade.Codigo <> '') then
        sSQL := sSQL + 'AND code = :codigo ';

      if (AEntidade.Nome <> '') then
        sSQL := sSQL + 'AND nome ILIKE :nome ';

      if (AEntidade.Email <> '') then
        sSQL := sSQL + 'AND email ILIKE :email ';

      if (AEntidade.Telefone <> '') then
        sSQL := sSQL + 'AND telefone ILIKE :telefone ';

      sSQL := sSQL + 'ORDER BY nome DESC';

      fGet.Close;
      fGet.SQL.Clear;
      fGet.SQL.Text := sSQL;

      if (AEntidade.Nome <> '') then
        fGet.ParamByName('nome').AsString   := '%' + AEntidade.Nome + '%';

      if (AEntidade.Codigo <> '') then
        fGet.ParamByName('codigo').AsString := AEntidade.Codigo;

      if (AEntidade.Codigo <> '') then
        fGet.ParamByName('email').AsString := AEntidade.Email;

      if (AEntidade.Codigo <> '') then
        fGet.ParamByName('telefone').AsString := TRegEx.Replace(AEntidade.Telefone, '\D', '');

      fGet.Open;
    finally
      Result := fGet;
    end;
end;

function TProfissionalDAO.ListarServicos(AProfissionalId: Int64): TFDQuery;
var
  sSQL: string;
  fGet: TFDQuery;
begin
  fGet := TFDQuery.Create(nil);
  try
    fGet.Connection := FConexao;

    sSQL := 'SELECT                                           '+
            'servico.id,                                      '+
            'servico.code as codigo,                          '+
            'profissional.nome as profissional,               '+
            'categoria.nome as categoria,                     '+
            'servico.preco                                    '+
            'FROM servicos_oferecidos as servico              '+
            'LEFT JOIN profissionais as profissional          '+
            'ON servico.profissional_id = profissional.id     '+
            'LEFT JOIN categorias_servico as categoria        '+
            'ON servico.categoria_id = categoria.id           '+
            'WHERE servico.profissional_id = :profissional_id '+
            'ORDER BY nome DESC                               ';

    fGet.Close;
    fGet.SQL.Clear;
    fGet.SQL.Text := sSQL;
    fGet.Open;
  finally
    Result := fGet;
  end;
end;

end.
