unit IRepositorio;

interface
uses
  System.SysUtils, System.Generics.Collections, FireDAC.Comp.Client;
type
  Repositorio<T: class> = interface
    procedure Inserir(AEntidade: T);
    procedure Atualizar(AEntidade: T);
    procedure Deletar(AEntidade: T);
    function BuscarPorId(AId: Int64): T;
    function Listar(AEntidade: T): TFDQuery;
  end;
implementation

end.
