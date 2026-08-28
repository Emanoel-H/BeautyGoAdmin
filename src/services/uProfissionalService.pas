unit uProfissionalService;

interface
uses
  System.SysUtils, IRepositorio, uProfissional, FireDAC.Comp.Client, uProfissionalDAO,
  Vcl.Forms, Winapi.Windows, uServicoOferecido;
type
  TProfissionalService = class
    private
      FDAO: Repositorio<TProfissional>;

      constructor Create(AConexao: TFDConnection);
      destructor Destroy; override;

      procedure Salvar(AProfissional: TProfissional);
      procedure Excluir(AProfissional: TProfissional);
      function Listar(AProfissional: TProfissional): TFDQuery;

      procedure Salvar(AServico: TServicoOferecido);
      procedure Excluir(AServico: TServicoOferecido);
      function Listar(AServico: TServicoOferecido): TFDQuery;

    public

  end;
implementation

{ TProfissionalService }

constructor TProfissionalService.Create(AConexao: TFDConnection);
begin
  FDAO := TProfissionalDAO.Create(AConexao);
end;

destructor TProfissionalService.Destroy;
begin

  inherited;
end;

procedure TProfissionalService.Excluir(AProfissional: TProfissional);
begin

end;

procedure TProfissionalService.Excluir(AServico: TServicoOferecido);
begin

end;

function TProfissionalService.Listar(AServico: TServicoOferecido): TFDQuery;
begin

end;

function TProfissionalService.Listar(AProfissional: TProfissional): TFDQuery;
begin

end;

procedure TProfissionalService.Salvar(AProfissional: TProfissional);
begin

end;

procedure TProfissionalService.Salvar(AServico: TServicoOferecido);
begin

end;

end.
