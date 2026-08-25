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
begin

end;

constructor TProfissionalDAO.Create(AConexao: TFDConnection);
begin

end;

procedure TProfissionalDAO.Deletar(AEntidade: TProfissional);
begin

end;

procedure TProfissionalDAO.DeletarServico(AServicoId: Int64);
begin

end;

function TProfissionalDAO.Existe(AEntidade: TProfissional): boolean;
begin

end;

procedure TProfissionalDAO.Inserir(AEntidade: TProfissional);
begin

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
