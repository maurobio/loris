Unit ImgForm;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Menus, Clipbrd, MsgDlg, Printers, ImgList;

Type
  TImageForm = Class (TForm)
    Image: TImage;
    SaveDialog: TSaveDialog;
    ImageMenu: TMainMenu;
    FileMenu: TMenuItem;
    FileSaveAsItem: TMenuItem;
    N1: TMenuItem;
    FilePrintItem: TMenuItem;
    EditMenu: TMenuItem;
    EditCopyItem: TMenuItem;
    FileReturnItem: TMenuItem;
    N2: TMenuItem;
    PrintDialog: TPrintDialog;
    ImageList: TImageList;
    Procedure FormShow (Sender: TObject);
    Procedure FileReturnItemClick (Sender: TObject);
    Procedure FilePrintItemClick (Sender: TObject);
    Procedure EditCopyItemClick (Sender: TObject);
    Procedure FileSaveAsItemClick (Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
    ImageFormBitmap: TBitmap;
  End;

Var
  ImageForm: TImageForm;

Implementation

{$R *.DFM}

//Uses Main;

Procedure TImageForm.FormShow (Sender: TObject);
Begin
  Image.Picture.Bitmap := ImageFormBitmap;
  Width := Image.Width + 30; { makes for better fit }
  ClientHeight := Image.Height;
  ClientWidth := Image.Width;
End;

Procedure TImageForm.FileReturnItemClick (Sender: TObject);
Begin
  Close;
End;

Procedure TImageForm.FilePrintItemClick (Sender: TObject);
Begin
  If PrintDialog.Execute Then Begin
    Printer.BeginDoc;
    Printer.Canvas.Draw (0, 0, ImageFormBitmap);
    Printer.EndDoc;
  End;
End;

Procedure TImageForm.EditCopyItemClick (Sender: TObject);
Begin
  Clipboard.Assign (Image.Picture);
  MessageBeep (mb_IconInformation);
  {MessageDlg ('Imagem copiada para a Área de Transferência',
    mtInformation, [mbOk], 0);}
  MessageDialog ('Informação', 'Imagem copiada para a Área de Transferência',
    mtInformation, [mbOk], ['OK']);	
End;

Procedure TImageForm.FileSaveAsItemClick (Sender: TObject);
Begin
  If SaveDialog.Execute Then
    Image.Picture.SaveToFile (SaveDialog.FileName);
End;

{Procedure TImageForm. ImageMenuGetItemParams (Sender: TMenu; Item: TMenuItem;
  State: TMenuOwnerDrawState; AFont: TFont; Var Color: TColor;
  Var Graphic: TGraphic; Var NumGlyphs: Integer);
Begin
  If Item = FileSaveAsItem Then Graphic := MainForm. SaveAsButton. Glyph
  Else If Item = FilePrintItem Then Graphic := MainForm. PrintButton. Glyph
  Else If Item = EditCopyItem Then Graphic := MainForm. CopyButton. Glyph;
End;}

End.

