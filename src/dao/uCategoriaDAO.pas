unit uCategoriaDAO;

interface
uses
  System.SysUtils, IRepositorio, uCategoria, System.Generics.Collections, uDmConexao,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param, FireDAC.Phys.PG, DB,
  Classes;
type
  TCategoriaDAO = class(TInterfacedObject, IRepositorio.Repositorio<TCategoria>)
  private
    FConexao: TFDConnection;
  public
    constructor Create(AConexao: TFDConnection);

    procedure Inserir(AEntidade: TCategoria);
    procedure Atualizar(AEntidade: TCategoria);
    procedure Deletar(AEntidade: TCategoria);
    function BuscarPorCodigo(ACodigo: string): TCategoria;
    function Listar(AEntidade: TCategoria): TFDQuery;
    function Existe(AEntidade: TCategoria): boolean;
  end;

implementation

{ TCategoriaDAO }

procedure TCategoriaDAO.Atualizar(AEntidade: TCategoria);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'UPDATE categorias_servico SET '+
            'nome = :nome,                 '+
            'descricao = :descricao        '+
            'WHERE id = :id                ';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ParamByName('nome').AsString      := AEntidade.Nome;
    fSet.ParamByName('descricao').AsString := AEntidade.Descricao;
    fSet.ParamByName('id').AsInteger       := AEntidade.Id;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;
end;

function TCategoriaDAO.BuscarPorCodigo(ACodigo: string): TCategoria;
var
  sSQL: string;
  fGet: TFDQuery;
  Categoria: TCategoria;
begin
  fGet := TFDQuery.Create(nil);
  try
    fGet.Connection := FConexao;

    sSQL := 'SELECT                  '+
            'id,                     '+
            'code as codigo,         '+
            'nome,                   '+
            'descricao               '+
            'FROM categorias_servico '+
            'WHERE code = :codigo    ';

    fGet.Close;
    fGet.SQL.Clear;
    fGet.SQL.Text := sSQL;
    fGet.ParamByName('codigo').AsString := ACodigo;
    fGet.Open;

    if not fGet.IsEmpty then
    begin
      Categoria           := TCategoria.Create;
      Categoria.Id        := fGet.FieldByName('id').AsInteger;
      Categoria.Nome      := fGet.FieldByName('nome').AsString;
      Categoria.Codigo    := fGet.FieldByName('codigo').AsString;
      Categoria.Descricao := fGet.FieldByName('descricao').AsString;

      Result := Categoria;
    end;

  finally
    fGet.Close;
    fGet.Free;
  end;
end;

constructor TCategoriaDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

procedure TCategoriaDAO.Deletar(AEntidade: TCategoria);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'DELETE FROM categorias_servico WHERE id = :id ';

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

function TCategoriaDAO.Existe(AEntidade: TCategoria): boolean;
var
  sSQL: string;
  fGet: TFDQuery;
begin
  fGet := TFDQuery.Create(nil);
  try
    fGet.Connection := FConexao;

    sSQL :=
    'SELECT id FROM servicos_oferecidos WHERE categoria_id = :categoria_id ';

    fGet.Close;
    fGet.SQL.Clear;
    fGet.SQL.Text := sSQL;
    fGet.ParamByName('categoria_id').AsInteger := AEntidade.Id;
    fGet.Open;

    Result := not (fGet.IsEmpty);
  finally
    fGet.Close;
    fGet.Free;
  end;
end;

procedure TCategoriaDAO.Inserir(AEntidade: TCategoria);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'INSERT INTO categorias_servico(nome, descricao)'+
            'VALUES(:nome, :descricao)';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ParamByName('nome').AsString      := AEntidade.Nome;
    fSet.ParamByName('descricao').AsString := AEntidade.Descricao;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;

end;

function TCategoriaDAO.Listar(AEntidade: TCategoria): TFDQuery;
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
              'descricao::VARCHAR(200) '+
              'FROM categorias_servico '+
              'WHERE 1=1               ';

      if (AEntidade.Codigo <> '') then
        sSQL := sSQL + 'AND code = :codigo ';

      if (AEntidade.Nome <> '') then
        sSQL := sSQL + 'AND nome ILIKE :nome ';

      sSQL := sSQL + 'ORDER BY nome DESC';

      fGet.Close;
      fGet.SQL.Clear;
      fGet.SQL.Text := sSQL;
      fGet.ParamByName('nome').AsString   := '%' + AEntidade.Nome + '%';
      fGet.ParamByName('codigo').AsString := AEntidade.Codigo;
      fGet.Open;
    finally
      Result := fGet;
    end;
end;

end.
