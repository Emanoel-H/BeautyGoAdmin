object frmServicosPesquisar: TfrmServicosPesquisar
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Servi'#231'os'
  ClientHeight = 636
  ClientWidth = 610
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
  object dbgServicos: TDBGrid
    Left = 0
    Top = 129
    Width = 610
    Height = 457
    Align = alClient
    Color = clBlack
    DataSource = dsServicos
    FixedColor = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Font.Quality = fqClearType
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDrawColumnCell = dbgServicosDrawColumnCell
    OnDblClick = dbgServicosDblClick
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
        FieldName = 'profissional'
        Title.Caption = 'Profissional'
        Title.Color = clWhite
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Title.Font.Quality = fqClearType
        Width = 239
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'categoria'
        Title.Caption = 'Categoria'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Title.Font.Quality = fqClearType
        Width = 204
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'preco'
        Title.Caption = 'Pre'#231'o'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -12
        Title.Font.Name = 'Segoe UI'
        Title.Font.Style = [fsBold]
        Title.Font.Quality = fqClearType
        Width = 80
        Visible = True
      end>
  end
  object pnMenu: TPanel
    Left = 0
    Top = 56
    Width = 610
    Height = 73
    Align = alTop
    Color = clBlack
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 604
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
    object lblCategorias: TLabel
      Left = 81
      Top = 2
      Width = 69
      Height = 17
      Caption = 'Categorias:'
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
    object lblPreco: TLabel
      Left = 489
      Top = 2
      Width = 38
      Height = 17
      Caption = 'Preco:'
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
      Width = 69
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
    end
    object nbPreco: TNumberBox
      Left = 489
      Top = 25
      Width = 112
      Height = 23
      Enabled = False
      TabOrder = 1
    end
    object dblCategorias: TDBLookupComboBox
      Left = 81
      Top = 25
      Width = 360
      Height = 23
      DropDownRows = 10
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      KeyField = 'id'
      ListField = 'nome'
      ParentFont = False
      TabOrder = 2
    end
  end
  object pnRodape: TPanel
    Left = 0
    Top = 586
    Width = 610
    Height = 50
    Align = alBottom
    Color = clBlack
    ParentBackground = False
    TabOrder = 2
    ExplicitTop = 577
    ExplicitWidth = 604
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
  object tbPesquisar: TToolBar
    Left = 0
    Top = 0
    Width = 610
    Height = 56
    ButtonHeight = 36
    ButtonWidth = 75
    Caption = 'tbPesquisar'
    Color = 6765239
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 6765239
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Images = dmConexao.VirtualImageList1
    ParentColor = False
    ParentFont = False
    TabOrder = 3
    ExplicitWidth = 604
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
      Hint = 'Pesquisar'
      Caption = 'btnPesquisar'
      ImageIndex = 24
      ImageName = 'search 72'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnPesquisarClick
    end
    object btnInserir: TToolButton
      Left = 150
      Top = 0
      Hint = 'Adicionar'
      Caption = 'btnAdicionar'
      ImageIndex = 19
      ImageName = 'plus 72'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnInserirClick
    end
    object btnAtualizar: TToolButton
      Left = 225
      Top = 0
      Hint = 'Atualizar'
      Caption = 'btnAtualizar'
      ImageIndex = 22
      ImageName = 'asterisk 72'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnAtualizarClick
    end
    object btnDeletar: TToolButton
      Left = 300
      Top = 0
      Hint = 'Deletar'
      Caption = 'btnDeletar'
      ImageIndex = 10
      ImageName = 'recycle'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnDeletarClick
    end
    object btnCancelar: TToolButton
      Left = 375
      Top = 0
      Hint = 'Cancelar'
      Caption = 'btnCancelar'
      Enabled = False
      ImageIndex = 20
      ImageName = 'cancel 72'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnCancelarClick
    end
    object btnConfirmar: TToolButton
      Left = 450
      Top = 0
      Hint = 'Confirmar'
      Caption = 'btnConfirmar'
      ImageIndex = 11
      ImageName = 'checkmark 72'
      ParentShowHint = False
      ShowHint = True
      OnClick = btnConfirmarClick
    end
  end
  object fdqServicos: TFDQuery
    Connection = dmConexao.FDConnection
    Left = 240
    Top = 104
  end
  object dsServicos: TDataSource
    DataSet = fdqServicos
    Left = 320
    Top = 104
  end
end
