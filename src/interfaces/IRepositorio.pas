unit IRepositorio;

interface
uses
  System.SysUtils, FireDAC.Comp.Client;
type
  Repositorio<T: class> = interface
    function Inserir(AEntidade: T): int64;
    procedure Atualizar(AEntidade: T);
    procedure Deletar(AEntidade: T);
    function BuscarPorCodigo(ACodigo: string): T;
    function Listar(AEntidade: T): TFDQuery;
    function Existe(AEntidade: T): boolean;
  end;
implementation

end.
