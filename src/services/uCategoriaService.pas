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

      function Salvar(ACategoria: TCategoria): int64;
      procedure Excluir(ACategoria: TCategoria);
      function Listar(ACategoria: TCategoria): TFDQuery;
  end;

implementation

{ TCategoriaService }

constructor TCategoriaService.Create(AConexao: TFDConnection);
begin
  FDAO := TCategoriaDAO.Create(AConexao);
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

function TCategoriaService.Salvar(ACategoria: TCategoria): int64;
begin
  if ACategoria.Nome = '' then
    raise Exception.Create('A Categoria deve possuir um nome!');

  if ACategoria.Id = 0 then
    ACategoria.Id := FDAO.Inserir(ACategoria)
  else
    FDAO.Atualizar(ACategoria);

  Result := ACategoria.Id;
end;

end.
