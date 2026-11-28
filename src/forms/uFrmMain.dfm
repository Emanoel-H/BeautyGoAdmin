object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Tela Principal'
  ClientHeight = 580
  ClientWidth = 646
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object pcMain: TPageControl
    Left = 8
    Top = 8
    Width = 630
    Height = 564
    ActivePage = Profissionais
    TabOrder = 0
    object Categorias: TTabSheet
      Caption = 'Categorias'
    end
    object Profissionais: TTabSheet
      AlignWithMargins = True
      Caption = 'Profissionais'
      ImageIndex = 1
    end
  end
end
