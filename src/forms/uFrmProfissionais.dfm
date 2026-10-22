object frmProfissionaisRegistrar: TfrmProfissionaisRegistrar
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Profissionais'
  ClientHeight = 568
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object pnPrincipal: TPanel
    Left = 0
    Top = 56
    Width = 496
    Height = 512
    Align = alClient
    Color = clBlack
    Enabled = False
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 478
    ExplicitHeight = 195
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
    object lblBio: TLabel
      Left = 14
      Top = 189
      Width = 24
      Height = 17
      Caption = 'Bio:'
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
    object lblEmail: TLabel
      Left = 14
      Top = 59
      Width = 38
      Height = 17
      Caption = 'Email:'
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
    object lblSenha: TLabel
      Left = 14
      Top = 104
      Width = 41
      Height = 17
      Caption = 'Senha:'
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
    object Label1: TLabel
      Left = 14
      Top = 147
      Width = 57
      Height = 17
      Caption = 'Telefone:'
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
    object edtNome: TEdit
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
    object mmBio: TMemo
      Left = 14
      Top = 209
      Width = 339
      Height = 89
      TabOrder = 1
    end
    object edtEmail: TEdit
      Left = 14
      Top = 78
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
      TabOrder = 2
    end
    object edtSenha: TEdit
      Left = 14
      Top = 123
      Width = 120
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImeName = 'edtValue2'
      MaxLength = 150
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 3
    end
    object edtTelefone: TEdit
      Left = 14
      Top = 166
      Width = 139
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ImeName = 'edtTelefone'
      MaxLength = 11
      NumbersOnly = True
      ParentFont = False
      TabOrder = 4
      OnChange = edtTelefoneChange
    end
  end
  object tbCategorias: TToolBar
    Left = 0
    Top = 0
    Width = 496
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
    TabOrder = 1
    ExplicitWidth = 478
    object btnVoltar: TToolButton
      Left = 0
      Top = 0
      Hint = 'Voltar'
      Caption = 'btnVoltar'
      ImageIndex = 6
      ImageName = 'back'
      ParentShowHint = False
      ShowHint = True
    end
    object btnCancelar: TToolButton
      Left = 67
      Top = 0
      Hint = 'Cancelar'
      Caption = 'cancel 72'
      Enabled = False
      ImageIndex = 20
      ImageName = 'cancel 72'
      ParentShowHint = False
      ShowHint = True
    end
    object btnDeletar: TToolButton
      Left = 134
      Top = 0
      Hint = 'Deletar'
      Caption = 'recycle'
      ImageIndex = 10
      ImageName = 'recycle'
      ParentShowHint = False
      ShowHint = True
    end
    object btnAtualizar: TToolButton
      Left = 201
      Top = 0
      Hint = 'Editar'
      Caption = 'btnAtualizar'
      ImageIndex = 22
      ImageName = 'asterisk 72'
      ParentShowHint = False
      ShowHint = True
    end
    object btnInserir: TToolButton
      Left = 268
      Top = 0
      Hint = 'Inserir'
      Caption = 'btnInserir'
      ImageIndex = 19
      ImageName = 'plus 72'
      ParentShowHint = False
      ShowHint = True
    end
    object btnPesquisar: TToolButton
      Left = 335
      Top = 0
      Hint = 'Pesquisar'
      Caption = 'btnPesquisar'
      ImageIndex = 24
      ImageName = 'search 72'
      ParentShowHint = False
      ShowHint = True
    end
    object btnConfirmar: TToolButton
      Left = 402
      Top = 0
      Hint = 'Confirmar'
      Caption = 'btnConfirmar'
      Enabled = False
      ImageIndex = 11
      ImageName = 'checkmark 72'
      ParentShowHint = False
      ShowHint = True
    end
  end
end
