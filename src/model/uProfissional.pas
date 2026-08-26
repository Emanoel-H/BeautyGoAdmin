unit uProfissional;

interface
uses
  System.SysUtils;

type
  TProfissional = class
    private
      iId: Int64;
      sNome: string;
      sBio: string;
      sCodigo: string;
      sEmail: string;
      sTelefone: string;
      sSenha: string;
      dRaioAtendimentoKm: Double;
      dLatitude: Double;
      dLongitude: Double;
    public
      property Id: Int64 read iId write iId;
      property Nome: string read sNome write sNome;
      property Bio: string read sBio write sBio;
      property Codigo: string read sCodigo write sCodigo;
      property Email: string read sEmail write sEmail;
      property Telefone: string read sTelefone write sTelefone;
      property Senha: string read sSenha write sSenha;
      property RaioAtendimentoKm: Double read dRaioAtendimentoKm write dRaioAtendimentoKm;
      property Latitude: Double read dLatitude write dLatitude;
      property Longitude: Double read dLongitude write dLongitude;
  end;

implementation

end.
