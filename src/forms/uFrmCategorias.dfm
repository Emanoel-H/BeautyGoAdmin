object frmCategoriasRegistrar: TfrmCategoriasRegistrar
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Categorias'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object tbCategorias: TToolBar
    Left = 0
    Top = 0
    Width = 628
    Height = 56
    ButtonHeight = 62
    ButtonWidth = 67
    Caption = 'tbCategorias'
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
    ExplicitWidth = 616
    object btnVoltar: TToolButton
      Left = 0
      Top = 0
      Hint = 'Back'
      Caption = 'btnVoltar'
      ImageIndex = 6
      ImageName = 'back'
      ParentShowHint = False
      ShowHint = True
    end
    object btnCancel: TToolButton
      Left = 67
      Top = 0
      Hint = 'Cancel'
      Caption = 'btnCancelar'
      Enabled = False
      ImageIndex = 20
      ImageName = 'cancel 72'
      ParentShowHint = False
      ShowHint = True
    end
    object btnDelete: TToolButton
      Left = 134
      Top = 0
      Hint = 'Delete Product'
      Caption = 'btnDeletar'
      ImageIndex = 10
      ImageName = 'recycle'
      ParentShowHint = False
      ShowHint = True
    end
    object btnUpdate: TToolButton
      Left = 201
      Top = 0
      Hint = 'Edit Product'
      Caption = 'btnAtualizar'
      ImageIndex = 22
      ImageName = 'asterisk 72'
      ParentShowHint = False
      ShowHint = True
    end
    object btnAdd: TToolButton
      Left = 268
      Top = 0
      Hint = 'Add Product'
      Caption = 'btnInserir'
      ImageIndex = 19
      ImageName = 'plus 72'
      ParentShowHint = False
      ShowHint = True
    end
    object btnSearch: TToolButton
      Left = 335
      Top = 0
      Hint = 'Search Products'
      Caption = 'btnPesquisar'
      ImageIndex = 24
      ImageName = 'search 72'
      ParentShowHint = False
      ShowHint = True
    end
    object btnConfirm: TToolButton
      Left = 402
      Top = 0
      Hint = 'Confirm'
      Caption = 'btnConfirmar'
      Enabled = False
      ImageIndex = 11
      ImageName = 'checkmark 72'
      ParentShowHint = False
      ShowHint = True
    end
  end
  object pnMain: TPanel
    Left = 0
    Top = 56
    Width = 628
    Height = 386
    Align = alClient
    Color = clBlack
    Enabled = False
    ParentBackground = False
    TabOrder = 1
    ExplicitWidth = 616
    ExplicitHeight = 368
    object lblName: TLabel
      Left = 14
      Top = 14
      Width = 41
      Height = 17
      Caption = 'Nome:'
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
    object lblDescricao: TLabel
      Left = 14
      Top = 60
      Width = 63
      Height = 17
      Caption = 'Descri'#231#227'o:'
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
    object edtName: TEdit
      Left = 14
      Top = 33
      Width = 341
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImeName = 'edtValue2'
      MaxLength = 150
      ParentFont = False
      TabOrder = 0
    end
    object mmDescricao: TMemo
      Left = 14
      Top = 80
      Width = 339
      Height = 89
      TabOrder = 1
    end
  end
end
