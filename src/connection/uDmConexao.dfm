object dmConexao: TdmConexao
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Users\henri\Desktop\Delphi Mastery\Win32\Debug\libpq 3.dll'
    Left = 480
    Top = 360
  end
  object FDConnection: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'Database=db_ace_DelphiMastery')
    LoginPrompt = False
    BeforeConnect = FDConnectionBeforeConnect
    Left = 624
    Top = 360
  end
end
