program BeautyGoAdmin;

uses
  Vcl.Forms,
  uFrmMain in 'src\forms\uFrmMain.pas' {frmMain},
  uDmConexao in 'src\connection\uDmConexao.pas' {dmConexao: TDataModule},
  Vcl.Themes,
  Vcl.Styles,
  uCategoria in 'src\model\uCategoria.pas',
  IRepositorio in 'src\interfaces\IRepositorio.pas',
  uCategoriaDAO in 'src\dao\uCategoriaDAO.pas',
  uCategoriaService in 'src\services\uCategoriaService.pas',
  uFrmCategorias in 'src\forms\uFrmCategorias.pas' {frmCategoriasRegistrar},
  uFrmCategoriasPesquisar in 'src\forms\uFrmCategoriasPesquisar.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Windows11 Dark');
  Application.CreateForm(TdmConexao, dmConexao);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
