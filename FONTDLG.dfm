object FontForm: TFontForm
  Left = 290
  Top = 128
  Hint = '|Para obter Ajuda, pressione F1'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Fontes e Cores      '
  ClientHeight = 339
  ClientWidth = 307
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = True
  ShowHint = True
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 225
    Top = 7
    Width = 16
    Height = 13
    Caption = '&Cor'
    FocusControl = FontColorGrid
  end
  object Label2: TLabel
    Left = 225
    Top = 99
    Width = 46
    Height = 13
    Caption = '&Destaque'
    FocusControl = HotSpotColorGrid
  end
  object Label3: TLabel
    Left = 225
    Top = 189
    Width = 45
    Height = 13
    Caption = '&Tamanho'
    FocusControl = FontSizeEdit
  end
  object Label4: TLabel
    Left = 9
    Top = 200
    Width = 28
    Height = 13
    Caption = '&Nome'
    FocusControl = FontListBox
  end
  object Label5: TLabel
    Left = 122
    Top = 200
    Width = 30
    Height = 13
    Caption = '&Fundo'
    FocusControl = BackListBox
  end
  object FontListBox: TListBox
    Left = 11
    Top = 217
    Width = 87
    Height = 115
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnClick = ListBoxClicks
  end
  object FontColorGrid: TColorGrid
    Left = 225
    Top = 23
    Width = 72
    Height = 72
    ClickEnablesColor = True
    ForegroundIndex = -1
    ForegroundEnabled = False
    BackgroundEnabled = False
    Selection = 3
    TabOrder = 2
    TabStop = True
    OnChange = FontColorGridChange
  end
  object HotSpotColorGrid: TColorGrid
    Left = 225
    Top = 114
    Width = 72
    Height = 72
    ClickEnablesColor = True
    ForegroundIndex = -1
    ForegroundEnabled = False
    BackgroundEnabled = False
    TabOrder = 3
    TabStop = True
    OnChange = HotSpotColorGridChange
  end
  object BackListBox: TListBox
    Left = 122
    Top = 217
    Width = 87
    Height = 115
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 1
    OnClick = ListBoxClicks
  end
  object FontViewer: THTMLViewer
    Left = 11
    Top = 13
    Width = 202
    Height = 184
    ViewImages = False
    TabOrder = 5
    BorderStyle = htFocused
    HistoryMaxCount = 0
    DefFontName = 'Times New Roman'
    DefPreFontName = 'Courier New'
    NoSelect = False
    CharSet = DEFAULT_CHARSET
    PrintMarginLeft = 2.000000000000000000
    PrintMarginRight = 2.000000000000000000
    PrintMarginTop = 2.000000000000000000
    PrintMarginBottom = 2.000000000000000000
    PrintScale = 1.000000000000000000
    htOptions = []
  end
  object FontSizeEdit: TSpinEdit
    Left = 225
    Top = 206
    Width = 65
    Height = 22
    MaxValue = 24
    MinValue = 6
    TabOrder = 4
    Value = 12
    OnChange = ListBoxClicks
  end
  object CancelButton: TButton
    Left = 222
    Top = 288
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancelar'
    ModalResult = 2
    TabOrder = 6
  end
  object OKButton: TButton
    Left = 222
    Top = 247
    Width = 75
    Height = 25
    Caption = 'O&K'
    Default = True
    ModalResult = 1
    TabOrder = 7
  end
end
