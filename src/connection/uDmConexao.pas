unit uDmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Phys.PGDef, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.PG, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, System.IniFiles,
  Vcl.Dialogs, System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  Vcl.BaseImageCollection, Vcl.ImageCollection;

type
  TdmConexao = class(TDataModule)
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    FDConnection: TFDConnection;
    ImageCollection1: TImageCollection;
    VirtualImageList1: TVirtualImageList;
    procedure FDConnectionBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmConexao: TdmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmConexao.FDConnectionBeforeConnect(Sender: TObject);
var
  Ini: TIniFile;
  sPath: string;
begin
  sPath := ExtractFilePath(ParamStr(0)) + 'config.ini';

  if not FileExists(sPath) then
  begin
    ShowMessage('Arquivo de configuração não foi encontrado!');
    Exit;
  end;

  Ini := TIniFile.Create(sPath);
  try
    FDConnection.Params.Values['Server']   := Ini.ReadString('Database', 'Server', 'localhost');
    FDConnection.Params.Values['Port']     := Ini.ReadString('Database', 'Port', '5432');
    FDConnection.Params.Values['User_Name'] := Ini.ReadString('Database', 'User', '');
    FDConnection.Params.Values['Password'] := Ini.ReadString('Database', 'Password', '');
    FDConnection.Params.Values['Database'] := Ini.ReadString('Database', 'Database', '');
  finally
    Ini.Free;
  end;
end;

end.
