object SubmitForm: TSubmitForm
  Left = 257
  Top = 159
  Hint = '|Para obter Ajuda, pressione F1'
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Resultados Submetidos      '
  ClientHeight = 279
  ClientWidth = 423
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = True
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 19
    Width = 28
    Height = 13
    Caption = 'A'#231#227'o:'
  end
  object Label2: TLabel
    Left = 16
    Top = 43
    Width = 39
    Height = 13
    Caption = 'M'#233'todo:'
  end
  object Label3: TLabel
    Left = 18
    Top = 71
    Width = 53
    Height = 13
    Caption = 'Resultados'
  end
  object ActionText: TEdit
    Left = 68
    Top = 14
    Width = 342
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 0
  end
  object MethodText: TEdit
    Left = 68
    Top = 41
    Width = 342
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 1
  end
  object ResultBox: TListBox
    Left = 17
    Top = 90
    Width = 392
    Height = 145
    TabStop = False
    ItemHeight = 13
    TabOrder = 2
  end
  object CloseButton: TButton
    Left = 174
    Top = 244
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Fechar'
    Default = True
    TabOrder = 3
    OnClick = CloseButtonClick
  end
end
