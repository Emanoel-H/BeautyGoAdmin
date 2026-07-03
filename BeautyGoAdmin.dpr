program BeautyGoAdmin;

uses
  Vcl.Forms,
  uFrmMain in 'src\forms\uFrmMain.pas' {frmMain},
  uDmConexao in 'src\connection\uDmConexao.pas' {dmConexao: TDataModule},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows11 Dark');
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
