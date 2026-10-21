unit uProfissionalService;

interface
uses
  System.SysUtils, IRepositorio, uProfissional, FireDAC.Comp.Client, uProfissionalDAO,
  Vcl.Forms, Winapi.Windows, uServicoOferecido;
type
  TProfissionalService = class
    private
      FDAO: Repositorio<TProfissional>;
      ProfissionalDAO: TProfissionalDAO;
    public
      constructor Create(AConexao: TFDConnection);
      destructor Destroy; override;

      procedure Salvar(AProfissional: TProfissional);
      procedure Excluir(AProfissional: TProfissional);
      function Listar(AProfissional: TProfissional): TFDQuery;

      procedure Salvar(AServico: TServicoOferecido);
      procedure Excluir(AServico: TServicoOferecido);
      function Listar(AServico: TServicoOferecido): TFDQuery;

  end;
implementation

{ TProfissionalService }

constructor TProfissionalService.Create(AConexao: TFDConnection);
var
  DAO: TProfissionalDAO;
begin
  DAO             := TProfissionalDAO.Create(AConexao);
  FDAO            := DAO;
  ProfissionalDAO := DAO;
end;

destructor TProfissionalService.Destroy;
begin

  inherited;
end;

procedure TProfissionalService.Excluir(AProfissional: TProfissional);
begin
  if FDAO.Existe(AProfissional) then
    raise Exception.Create('Este profissional possui serviços vinculados e não pode ser excluída.');

  FDAO.Deletar(AProfissional);
end;

procedure TProfissionalService.Excluir(AServico: TServicoOferecido);
begin
  ProfissionalDAO.DeletarServico(AServico.Id);
end;

function TProfissionalService.Listar(AServico: TServicoOferecido): TFDQuery;
begin
  Result := ProfissionalDAO.ListarServicos(AServico.Id);
end;

function TProfissionalService.Listar(AProfissional: TProfissional): TFDQuery;
begin
  Result := FDAO.Listar(AProfissional);
end;

procedure TProfissionalService.Salvar(AProfissional: TProfissional);
begin
  if AProfissional.Nome = '' then
    raise Exception.Create('O Profissional deve possuir um nome!');

  if AProfissional.Email = '' then
    raise Exception.Create('O Profissional deve possuir um email!');

  if AProfissional.Senha = '' then
    raise Exception.Create('O Profissional deve possuir uma senha!');

  if AProfissional.Telefone = '' then
    raise Exception.Create('O Profissional deve possuir um telefone!');

  if AProfissional.RaioAtendimentoKm <= 0 then
    raise Exception.Create('O raio de atendimento do Profissional deve ser maior que 0!');

  if AProfissional.Id = 0 then
    FDAO.Inserir(AProfissional)
  else
    FDAO.Atualizar(AProfissional);
end;

procedure TProfissionalService.Salvar(AServico: TServicoOferecido);
begin
  if AServico.ProfissionalId = 0 then
    raise Exception.Create('O Serviço deve possuir um profissional!');

  if AServico.CategoriaId = 0 then
    raise Exception.Create('O Serviço deve possuir uma categoria!');

  if AServico.Id = 0 then
    ProfissionalDAO.InserirServico(AServico)
  else
    ProfissionalDAO.AtualizarServico(AServico);
end;

end.
