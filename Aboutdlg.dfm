object AboutBox: TAboutBox
  Left = 290
  Top = 189
  Hint = '|Para obter Ajuda, pressione F1'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Sobre o Loris      '
  ClientHeight = 213
  ClientWidth = 298
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object Panel: TPanel
    Left = 8
    Top = 8
    Width = 281
    Height = 161
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object ProgramIcon: TImage
      Left = 8
      Top = 9
      Width = 32
      Height = 32
      AutoSize = True
      Picture.Data = {
        055449636F6E0000010001002020100000000000E80200001600000028000000
        2000000040000000010004000000000080020000000000000000000000000000
        0000000000000000000080000080000000808000800000008000800080800000
        80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
        FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        0FFFFFFFFFFFFFFFFFFF0000FFFFFFFF00FFFFFFFFFFFFFFF0000FFFFFFFFFFF
        F000FFFFFFFFFF0000FFFFFFFFFFFFFFFFF00FFFFFFFF00FFFFFFFFFFFFFFFFF
        FFFF0FFFFFFF00FFFFFFFFFFFF0000FFFFFFFFFFF0F00FFFFFFFFFFFF000000F
        FFFFFFFFF0F0FFFFFFFFFFFFF000000FFFFFFFFFF0000FFFFFFFFFFFF000000F
        FFFFFFFFFFF00000FFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0
        000FFFFFFFFFFFFF00000FFFFFFFF000BBB00FFFFFFFFF00BBBB000FFFFF00BB
        BBBB00FFFFFF00BBBBBBBB000FFF0BBBBBBBB0FFFFF0BBBBBBBBBBBB00F0BB00
        BBBBBB0FFFF0BBBBBBBB000BB0F0B0000BBBBB0FFF0BBBBBBBB00000BB00B000
        0BBBBB0FFF0BBBBBBBB00000BB00B0000BBBBB0FFF0BBBBBBBBB000BBB00BB00
        BBBBBB0FFF0BBBBBBBBBBBBBBB00BBBBBBBBBB0FFF0BBBBBBBBBBBBBBB00BBBB
        BBBBBB0FFFF0BBBBBBBBBBBBB0F0BBBBBBBBBB0FFFF0BBBBBBBBBBBBB0FF0BBB
        BBBBB0FFFFFF00BBBBBBBBB00FFF00BBBBBBB0FFFFFFFF00BBBBB000FFFFF00B
        BBB00FFFFFFFFFFF000000FFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF00000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000}
      Stretch = True
      IsControl = True
    end
    object ProductName: TLabel
      Left = 111
      Top = 10
      Width = 59
      Height = 29
      Caption = 'Loris'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -24
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Version: TLabel
      Left = 109
      Top = 61
      Width = 63
      Height = 14
      Caption = 'Vers'#227'o 10.0'
      Font.Charset = ANSI_CHARSET
      Font.Color = clPurple
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      IsControl = True
    end
    object Copyright: TLabel
      Left = 61
      Top = 84
      Width = 160
      Height = 13
      Alignment = taCenter
      Caption = #169' 1996-2023 Mauro J. Cavalcanti'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      IsControl = True
    end
    object Comments: TLabel
      Left = 50
      Top = 36
      Width = 181
      Height = 16
      Caption = 'Visualizador de Arquivos HTML'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsItalic]
      ParentFont = False
      WordWrap = True
      IsControl = True
    end
    object FlagIcon: TImage
      Left = 241
      Top = 9
      Width = 32
      Height = 32
      Hint = 
        '"Pense globalmente, aja localmente"|Para obter Ajuda, pressione ' +
        'F1'
      AutoSize = True
      ParentShowHint = False
      Picture.Data = {
        055449636F6E0000010001002020100000000000E80200001600000028000000
        2000000040000000010004000000000080020000000000000000000000000000
        0000000000000000000080000080000000808000800000008000800080800000
        80808000C0C0C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000
        FFFFFF0000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000022222222222222222222222
        2222222002222222222222222222222222222220022222222222222BB2222222
        22222220022222222222BBBBBBBB2222222222200222222222BBBBBBBBBBBB22
        2222222002222222BBBBBCCCCCCBBBBB2222222002222BBBBBBBCFCCFCCCBBBB
        BBB22220022BBBBBBBBCCCCFCCCCFBBBBBBBB22002BBBBBBBBBCCFCCCCFFCBBB
        BBBBBB2002BBBBBBBBBCCCCCFFCCCBBBBBBBBB20022BBBBBBBBCCCFFCCCCCBBB
        BBBBB22002222BBBBBBBCCCCCFCCBBBBBBB2222002222222BBBBBCCCCCCBBBBB
        222222200222222222BBBBBBBBBBBB2222222220022222222222BBBBBBBB2222
        22222220022222222222222BB222222222222220022222222222222222222222
        2222222002222222222222222222222222222220000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFF}
      ShowHint = True
      Stretch = True
      IsControl = True
    end
    object Email: TLabel
      Left = 90
      Top = 120
      Width = 101
      Height = 13
      Cursor = crHandPoint
      Hint = '|Envia mensagens para maurobio@ig.com.br'
      Alignment = taCenter
      Caption = 'maurobio@gmail.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      Transparent = True
      OnClick = EmailClick
    end
    object City: TLabel
      Left = 90
      Top = 99
      Width = 112
      Height = 13
      Alignment = taCenter
      Caption = 'Rio de Janeiro, BRASIL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object URL: TLabel
      Left = 90
      Top = 136
      Width = 100
      Height = 13
      Cursor = crHandPoint
      Hint = '|Atalho para http://www.maurobio.cjb.net'
      Caption = 'github.com/maurobio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Pitch = fpVariable
      Font.Style = [fsUnderline]
      ParentFont = False
      Transparent = True
      OnClick = URLClick
    end
  end
  object OKButton: TButton
    Left = 112
    Top = 176
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'O&K'
    Default = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = []
    ModalResult = 1
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
  end
end
