object frmCategoriasPesquisar: TfrmCategoriasPesquisar
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pesquisar Categorias'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object tbCategoriasPesquisar: TToolBar
    Left = 0
    Top = 0
    Width = 628
    Height = 56
    ButtonHeight = 62
    ButtonWidth = 75
    Caption = 'tbCategoriasPesquisar'
    Color = 6765239
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6765239
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Images = dmConexao.VirtualImageList1
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    ExplicitWidth = 622
    object btnVoltar: TToolButton
      Left = 0
      Top = 0
      Hint = 'Voltar'
      Caption = 'btnVoltar'
      ImageIndex = 6
      ImageName = 'back'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnVoltarClick
    end
    object btnPesquisar: TToolButton
      Left = 75
      Top = 0
      Hint = 'Pesquisar Categorias'
      Caption = 'btnPesquisar'
      ImageIndex = 24
      ImageName = 'search 72'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnPesquisarClick
    end
    object btnConfirmar: TToolButton
      Left = 150
      Top = 0
      Hint = 'Confirmar'
      Caption = 'btnConfirmar'
      ImageIndex = 11
      ImageName = 'checkmark 72'
      ParentShowHint = False
      ShowHint = True
    end
  end
  object dbgCategorias: TDBGrid
    Left = 0
    Top = 129
    Width = 628
    Height = 263
    Align = alClient
    Color = clBlack
    DataSource = dsCategorias
    FixedColor = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Font.Quality = fqClearType
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = dbgCategoriasDrawColumnCell
    OnDblClick = dbgCategoriasDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'codigo'
        Title.Caption = 'C'#243'digo'
        Title.Color = clWhite
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Title.Font.Quality = fqClearType
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'id'
        Title.Color = clWhite
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'nome'
        Title.Caption = 'Categoria'
        Title.Color = clWhite
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Title.Font.Quality = fqClearType
        Width = 375
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Title.Caption = 'Descricao'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Title.Font.Quality = fqClearType
        Visible = True
      end>
  end
  object pnRodape: TPanel
    Left = 0
    Top = 392
    Width = 628
    Height = 50
    Align = alBottom
    Color = clBlack
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 383
    ExplicitWidth = 622
    object pnRegistros: TPanel
      Left = 1
      Top = 1
      Width = 63
      Height = 48
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblRegistros: TLabel
        Left = 4
        Top = 5
        Width = 57
        Height = 17
        Alignment = taCenter
        Caption = 'Registros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        ParentFont = False
      end
      object lblQtdeRegistros: TLabel
        Left = 30
        Top = 22
        Width = 7
        Height = 17
        Alignment = taCenter
        Caption = '0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        ParentFont = False
      end
    end
  end
  object pnMenu: TPanel
    Left = 0
    Top = 56
    Width = 628
    Height = 73
    Align = alTop
    Color = clBlack
    ParentBackground = False
    TabOrder = 3
    ExplicitWidth = 622
    object lblCodigo: TLabel
      Left = 6
      Top = 2
      Width = 48
      Height = 17
      Caption = 'C'#243'digo:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      ParentColor = False
      ParentFont = False
    end
    object lblNome: TLabel
      Left = 88
      Top = 2
      Width = 63
      Height = 17
      Caption = 'Categoria:'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      Font.Quality = fqClearType
      ParentColor = False
      ParentFont = False
    end
    object edtCodigo: TEdit
      Left = 6
      Top = 25
      Width = 60
      Height = 23
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Font.Quality = fqClearType
      ImeName = 'edtValue1'
      MaxLength = 10
      NumbersOnly = True
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtCodigoKeyPress
    end
    object edtNome: TEdit
      Left = 88
      Top = 25
      Width = 353
      Height = 23
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      Font.Quality = fqClearType
      ImeName = 'edtValue2'
      MaxLength = 150
      ParentFont = False
      TabOrder = 1
    end
  end
  object fdqCategorias: TFDQuery
    Connection = dmConexao.FDConnection
    Left = 240
  end
  object dsCategorias: TDataSource
    DataSet = fdqCategorias
    Left = 320
  end
end
