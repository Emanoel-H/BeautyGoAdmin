unit IRepositorio;

interface
uses
  System.SysUtils, System.Generics.Collections;
type
  Repositorio<T: class> = interface
    procedure Inserir(AEntidade: T);
    procedure Atualizar(AEntidade: T);
    procedure Deletar(AEntidade: T);
    function BuscarPorId(AId: Int64): T;
    function BuscarTodos: TObjectList<T>;
  end;
implementation

end.
