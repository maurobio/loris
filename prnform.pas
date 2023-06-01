Unit PrnForm;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, HTMLView, MetaFilePrinter;

Const
  wm_StartPreview = wm_User + 22;
  wm_StartPrint = wm_User + 23;

Type
  TPrnStatusForm = Class (TForm)
    StatusLabel: TLabel;
    CancelButton: TButton;
    Procedure CancelButtonClick (Sender: TObject);
  Private
    { Private declarations }
    Viewer: ThtmlViewer;
    Canceled: Boolean;
    MFPrinter: TMetaFilePrinter;
    FromPage, ToPage: Integer;
    Procedure wmStartPreview (Var Message: TMessage); Message wm_StartPreview;
    Procedure wmStartPrint (Var Message: TMessage); Message wm_StartPrint;
    Procedure PageEvent (Sender: TObject; PageNum: Integer; Var Stop: Boolean);
  Public
    { Public declarations }
    Procedure DoPreview (AViewer: ThtmlViewer; AMFPrinter: TMetaFilePrinter; Var Abort: Boolean);
    Procedure DoPrint (AViewer: ThtmlViewer; FromPg, ToPg: Integer;	Var Abort: Boolean);
  End;

Var
  PrnStatusForm: TPrnStatusForm;

Implementation

{$R *.DFM}

Procedure TPrnStatusForm.DoPreview (AViewer: ThtmlViewer; AMFPrinter:
  TMetaFilePrinter; Var Abort: Boolean);
Begin
  Viewer := AViewer;
  MFPrinter := AMFPrinter;
  Viewer.OnPageEvent := PageEvent;
  Try
    PostMessage (Handle, Wm_StartPreview, 0, 0);
    Abort := ShowModal = mrCancel;
  Finally
    Viewer.OnPageEvent := Nil;
  End;
End;

Procedure TPrnStatusForm.DoPrint (AViewer: ThtmlViewer; FromPg, ToPg: Integer;
  Var Abort: Boolean);
Begin
  Viewer := AViewer;
  FromPage := FromPg;
  ToPage := ToPg;
  Viewer.OnPageEvent := PageEvent;
  Try
    PostMessage (Handle, Wm_StartPrint, 0, 0);
    Abort := ShowModal = mrCancel;
  Finally
    Viewer.OnPageEvent := Nil;
  End;
End;

Procedure TPrnStatusForm.PageEvent (Sender: TObject; PageNum: Integer; Var
  Stop: Boolean);
Begin
  If Canceled Then
    Stop := True
  Else
    If PageNum = 0 Then
      StatusLabel.Caption := 'Formatando'
    Else
      StatusLabel.Caption := 'Página Número ' + IntToStr (PageNum);
    Update;
End;

Procedure TPrnStatusForm.wmStartPreview (Var Message: TMessage);
Begin
   Viewer.PrintPreview (MFPrinter);
   If Canceled Then
     ModalResult := mrCancel
   Else ModalResult := mrOK;
End;

Procedure TPrnStatusForm.wmStartPrint (Var Message: TMessage);
Begin
  Viewer.Print (FromPage, ToPage);
  If Canceled Then
    ModalResult := mrCancel
  Else ModalResult := mrOK;
End;

Procedure TPrnStatusForm.CancelButtonClick (Sender: TObject);
Begin
  Canceled := True;
End;

End.

