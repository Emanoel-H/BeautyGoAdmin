program BeautyGoAdmin;

uses
  Vcl.Forms,
  uFrmMain in 'src\forms\uFrmMain.pas' {frmMain},
  uDmConexao in 'src\connection\uDmConexao.pas' {dmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmConexao, dmConexao);
  Application.Run;
end.
