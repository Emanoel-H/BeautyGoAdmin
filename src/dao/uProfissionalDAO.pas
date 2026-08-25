unit uProfissionalDAO;

interface
uses
  System.SysUtils, IRepositorio, uProfissional, System.Generics.Collections, uDmConexao,
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

  end;

implementation

{ TProfissionalDAO }

procedure TProfissionalDAO.Atualizar(AEntidade: TProfissional);
begin

end;

function TProfissionalDAO.BuscarPorCodigo(ACodigo: string): TProfissional;
begin

end;

constructor TProfissionalDAO.Create(AConexao: TFDConnection);
begin

end;

procedure TProfissionalDAO.Deletar(AEntidade: TProfissional);
begin

end;

function TProfissionalDAO.Existe(AEntidade: TProfissional): boolean;
begin

end;

procedure TProfissionalDAO.Inserir(AEntidade: TProfissional);
begin

end;

function TProfissionalDAO.Listar(AEntidade: TProfissional): TFDQuery;
begin

end;

end.
