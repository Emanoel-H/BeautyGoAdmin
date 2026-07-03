unit uCategoria;

interface
uses
  System.SysUtils;

type
  TuCategoria = class
    private
      iId: Int64;
      sNome: string;
      sDescricao: string;
    public
      property Id: Int64 read iId write iId;
      property Nome: string read sNome write sNome;
      property Descricao: string read sDescricao write sDescricao;
  end;
implementation

end.
