object PrnStatusForm: TPrnStatusForm
  Left = 296
  Top = 188
  BorderStyle = bsDialog
  Caption = 'Imprimindo'
  ClientHeight = 96
  ClientWidth = 247
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Pitch = fpVariable
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StatusLabel: TLabel
    Left = 13
    Top = 24
    Width = 222
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Status'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object CancelButton: TButton
    Left = 86
    Top = 56
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancelar'
    Default = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Pitch = fpVariable
    Font.Style = []
    ModalResult = 2
    ParentFont = False
    TabOrder = 0
    OnClick = CancelButtonClick
  end
end
