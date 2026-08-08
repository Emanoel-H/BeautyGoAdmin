unit uCategoriaService;

interface
uses
  System.SysUtils, IRepositorio, uCategoria, FireDAC.Comp.Client, uCategoriaDAO, Vcl.Forms, Winapi.Windows;
type
  TCategoriaService = class
    private
      FDAO: Repositorio<TCategoria>;
    public
      constructor Create(AConexao: TFDConnection);
      destructor Destroy; override;

      procedure Salvar(ACategoria: TCategoria);
      procedure Excluir(ACategoria: TCategoria);
      function Listar(ACategoria: TCategoria): TFDQuery;
  end;

implementation

{ TCategoriaService }

constructor TCategoriaService.Create(AConexao: TFDConnection);
begin
  FDAO := CategoriaDAO.Create(AConexao);
end;

destructor TCategoriaService.Destroy;
begin

  inherited;
end;

procedure TCategoriaService.Excluir(ACategoria: TCategoria);
begin
  if FDAO.Existe(ACategoria) then
    raise Exception.Create('Esta categoria possui serviços vinculados e não pode ser excluída.');

  FDAO.Deletar(ACategoria);
end;

function TCategoriaService.Listar(ACategoria: TCategoria): TFDQuery;
begin
  Result := FDAO.Listar(ACategoria);
end;

procedure TCategoriaService.Salvar(ACategoria: TCategoria);
begin
  if ACategoria.Nome = '' then
    raise Exception.Create('A Categoria deve possuir um nome!');

  if ACategoria.Id = 0 then
    FDAO.Inserir(ACategoria)
  else
    FDAO.Atualizar(ACategoria);
end;

end.
