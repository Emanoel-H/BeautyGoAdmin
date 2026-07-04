unit IRepositorio;

interface
uses
  System.SysUtils, FireDAC.Comp.Client;
type
  Repositorio<T: class> = interface
    procedure Inserir(AEntidade: T);
    procedure Atualizar(AEntidade: T);
    procedure Deletar(AEntidade: T);
    function BuscarPorCodigo(ACodigo: string): T;
    function Listar(AEntidade: T): TFDQuery;
  end;
implementation

end.
