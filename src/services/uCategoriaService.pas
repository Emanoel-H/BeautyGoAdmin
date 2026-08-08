unit uCategoriaService;

interface
uses
  System.SysUtils, IRepositorio, uCategoria, FireDAC.Comp.Client, uCategoriaDAO, Vcl.Forms, Winapi.Windows;
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
  if FDAO.Existe(ACategoria) then
    raise Exception.Create('Esta categoria possui serviços vinculados e não pode ser excluída.');

  FDAO.Deletar(ACategoria);
end;

function CategoriaService.Listar(ACategoria: TuCategoria): TFDQuery;
begin
  Result := FDAO.Listar(ACategoria);
end;

procedure CategoriaService.Salvar(ACategoria: TuCategoria);
begin
  if ACategoria.Nome = '' then
    raise Exception.Create('A Categoria deve possuir um nome!');

  if ACategoria.Id = 0 then
    FDAO.Inserir(ACategoria)
  else
    FDAO.Atualizar(ACategoria);
end;

end.
