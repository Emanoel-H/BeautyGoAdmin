unit uCategoriaDAO;

interface
uses
  System.SysUtils, IRepositorio, uCategoria, System.Generics.Collections, uDmConexao,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param, FireDAC.Phys.PG, DB,
  Classes;
type
  CategoriaDAO = class(TInterfacedObject, IRepositorio.Repositorio<TuCategoria>)
  private
    FConexao: TFDConnection;
  public
    constructor Create(AConexao: TFDConnection);

    procedure Inserir(AEntidade: TuCategoria);
    procedure Atualizar(AEntidade: TuCategoria);
    procedure Deletar(AEntidade: TuCategoria);
    function BuscarPorCodigo(ACodigo: string): TuCategoria;
    function Listar(AEntidade: TuCategoria): TFDQuery;
    function Existe(AEntidade: TuCategoria): boolean;
  end;

implementation

{ CategoriaDAO }

procedure CategoriaDAO.Atualizar(AEntidade: TuCategoria);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'UPDATE categorias_servico SET            '+
            'nome = '''+AEntidade.Nome+''',           '+
            'descricao = '''+AEntidade.Descricao+'''  '+
            'WHERE id = '''+AEntidade.Id.ToString+''' ';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;
end;

function CategoriaDAO.BuscarPorCodigo(ACodigo: string): TuCategoria;
var
  sSQL: string;
  fGet: TFDQuery;
  Categoria: TuCategoria;
begin
  fGet := TFDQuery.Create(nil);
  try
    fGet.Connection := FConexao;

    sSQL := 'SELECT                       '+
            'id,                          '+
            'code as codigo,              '+
            'nome,                        '+
            'descricao                    '+
            'FROM categorias_servico      '+
            'WHERE code = '''+ACodigo+''' ';

    fGet.Close;
    fGet.SQL.Clear;
    fGet.SQL.Text := sSQL;
    fGet.Open;

    if not fGet.IsEmpty then
    begin
      Categoria           := TuCategoria.Create;
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

constructor CategoriaDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

procedure CategoriaDAO.Deletar(AEntidade: TuCategoria);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'DELETE FROM categorias_servico WHERE id = '''+AEntidade.Id.ToString+''' ';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;
end;

function CategoriaDAO.Existe(AEntidade: TuCategoria): boolean;
var
  sSQL: string;
  fGet: TFDQuery;
begin
  fGet := TFDQuery.Create(nil);
  try
    fGet.Connection := FConexao;

    sSQL :=
    'SELECT id FROM servicos_oferecidos WHERE categoria_id = '''+AEntidade.Id.ToString+''' ';

    fGet.Close;
    fGet.SQL.Clear;
    fGet.SQL.Text := sSQL;
    fGet.Open;

    Result := not (fGet.IsEmpty);
  finally
    fGet.Close;
    fGet.Free;
  end;
end;

procedure CategoriaDAO.Inserir(AEntidade: TuCategoria);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := FConexao;

    sSQL := 'INSERT INTO categorias_servico(nome, descricao)'+
            'VALUES('''+AEntidade.Nome+''', '''+AEntidade.Descricao+''')';

    fSet.Close;
    fSet.SQL.Clear;
    fSet.SQL.Text := sSQL;
    fSet.ExecSQL;
  finally
    fSet.Close;
    fSet.Free;
  end;

end;

function CategoriaDAO.Listar(AEntidade: TuCategoria): TFDQuery;
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
      sSQL := sSQL + 'AND code = '''+AEntidade.Codigo+''' ';

    if (AEntidade.Nome <> '') then
      sSQL := sSQL + 'AND nome ILIKE ''%'+AEntidade.Nome+'%'' ';

    sSQL := sSQL + 'ORDER BY nome DESC';

    fGet.Close;
    fGet.SQL.Clear;
    fGet.SQL.Text := sSQL;
    fGet.Open;

    if not fGet.IsEmpty then
      Result := fGet;
  except on E: Exception do
    begin
      fGet.Close;
      fGet.Free;
    end;
  end;
end;

end.
