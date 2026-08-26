unit uServicoOferecido;

interface
uses
  System.SysUtils;

type
  TServicoOferecido = class
    private
      iId: Int64;
      iCategoriaId: Int64;
      iProfissionalId: Int64;
      sCodigo: string;
      cPreco: Currency;
    public
      property Id: Int64 read iId write iId;
      property CategoriaId: Int64 read iCategoriaId write iCategoriaId;
      property ProfissionalId: Int64 read iProfissionalId write iProfissionalId;
      property Codigo: string read sCodigo write sCodigo;
      property dPreco: Currency read cPreco write cPreco;
  end;

implementation

end.
