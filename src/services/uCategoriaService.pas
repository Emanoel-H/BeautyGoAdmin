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
  begin
    Application.MessageBox('Esta categoria possui serviços vinculados e não pode ser excluída.', 'Erro de exclusão', MB_OK + MB_ICONERROR);
    Abort;
  end;


  FDAO.Deletar(ACategoria);
end;

function CategoriaService.Listar(ACategoria: TuCategoria): TFDQuery;
begin

end;

procedure CategoriaService.Salvar(ACategoria: TuCategoria);
begin

end;

end.
