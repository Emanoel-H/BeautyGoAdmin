unit uCategoriaDAO;

interface
uses
  System.SysUtils, IRepositorio, uCategoria, System.Generics.Collections, uDmConexao,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, FireDAC.Stan.Param, FireDAC.Phys.PG, DB,
  Classes;
type
  CategoriaDAO = class(TInterfacedObject, IRepositorio.Repositorio<TuCategoria>)
  private

  public
    procedure Inserir(AEntidade: TuCategoria);
    procedure Atualizar(AEntidade: TuCategoria);
    procedure Deletar(AEntidade: TuCategoria);
    function BuscarPorId(AId: Int64): TuCategoria;
    function BuscarTodos: TObjectList<TuCategoria>;
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
    fSet.Connection := dmConexao.FDConnection;

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

function CategoriaDAO.BuscarPorId(AId: Int64): TuCategoria;
begin

end;

function CategoriaDAO.BuscarTodos: TObjectList<TuCategoria>;
begin

end;

procedure CategoriaDAO.Deletar(AEntidade: TuCategoria);
begin

end;

procedure CategoriaDAO.Inserir(AEntidade: TuCategoria);
var
  sSQL: string;
  fSet: TFDQuery;
begin
  fSet := TFDQuery.Create(nil);
  try
    fSet.Connection := dmConexao.FDConnection;

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

end.
