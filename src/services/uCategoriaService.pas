unit uCategoriaService;

interface
uses
  System.SysUtils, IRepositorio, uCategoria, FireDAC.Comp.Client, uCategoriaDAO;
type
  CategoriaService = class
    private
      FDAO: Repositorio<TuCategoria>;
    public
      constructor Create(AConexao: TFDConnection);
      destructor Destroy; override;

      procedure Salvar(ACategoria: TuCategoria);
      procedure Excluir(ACategoria: TuCategoria);
      function Listar(ACategoria: TuCategoria): TFDQuery;
  end;

implementation

{ CategoriaService }

constructor CategoriaService.Create(AConexao: TFDConnection);
begin
  FDAO := CategoriaDAO.Create(AConexao);
end;

destructor CategoriaService.Destroy;
begin

  inherited;
end;

procedure CategoriaService.Excluir(ACategoria: TuCategoria);
begin

end;

function CategoriaService.Listar(ACategoria: TuCategoria): TFDQuery;
begin

end;

procedure CategoriaService.Salvar(ACategoria: TuCategoria);
begin

end;

end.
