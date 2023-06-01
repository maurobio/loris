Unit PrvForm;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, MetaFilePrinter, HTMLView;

Const
  crZoom = 40;
  crHandDrag = 41;
  ZOOMFACTOR = 1.5;

Type
  TPreviewForm = Class (TForm)
    ToolBarPanel: TPanel;
    ZoomCursorBtn: TSpeedButton;
    HandCursorBtn: TSpeedButton;
    OnePageBtn: TSpeedButton;
    TwoPageBtn: TSpeedButton;
    PrintBtn: TSpeedButton;
    NextPageBtn: TSpeedButton;
    PrevPageBtn: TSpeedButton;
    ZoomBox: TComboBox;
    StatBarPanel: TPanel;
    CurPageLabel: TPanel;
    ZoomLabel: TPanel;
    HintPanel: TPanel;
    HintLabel: TLabel;
    MoveButPanel: TPanel;
    FirstPageSpeed: TSpeedButton;
    PrevPageSpeed: TSpeedButton;
    NextPageSpeed: TSpeedButton;
    LastPageSpeed: TSpeedButton;
    ScrollBox: TScrollBox;
    ContainPanel: TPanel;
    PagePanel: TPanel;
    PB1: TPaintBox;
    PagePanel2: TPanel;
    PB2: TPaintBox;
    PrintDialog1: TPrintDialog;
    FitPageBtn: TSpeedButton;
    FitWidthBtn: TSpeedButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Bevel5: TBevel;
    Bevel7: TBevel;
    Bevel4: TBevel;
    CloseBtn: TSpeedButton;
    Procedure CloseButClick (Sender: TObject);
    Procedure FormClose (Sender: TObject; Var Action: TCloseAction);
    Procedure ScrollBoxResize (Sender: TObject);
    Procedure PBPaint (Sender: TObject);
    Procedure FormShow (Sender: TObject);
    Procedure ZoomBoxChange (Sender: TObject);
    Procedure TwoPageBtnClick (Sender: TObject);
    Procedure NextPageBtnClick (Sender: TObject);
    Procedure PrevPageBtnClick (Sender: TObject);
    Procedure FirstPageSpeedClick (Sender: TObject);
    Procedure LastPageSpeedClick (Sender: TObject);
    Procedure ZoomCursorBtnClick (Sender: TObject);
    Procedure HandCursorBtnClick (Sender: TObject);
    Procedure PB1MouseDown (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure PB1MouseMove (Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    Procedure PB1MouseUp (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure PrintBtnClick (Sender: TObject);
    Procedure OnePageBtnMouseUp (Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure FitPageBtnClick (Sender: TObject);
    Procedure FitWidthBtnClick (Sender: TObject);
    Procedure CloseBtnClick (Sender: TObject);
  Private
    Viewer: ThtmlViewer;
  Protected
    FCurPage: Integer;
    OldHint: TNotifyEvent;
    DownX, DownY: Integer;
    Moving: Boolean;
    MFPrinter: TMetaFilePrinter;
    Procedure DrawMetaFile (PB: TPaintBox; mf: TMetaFile);
    Procedure OnHint (Sender: TObject);
    Procedure SetCurPage (Val: Integer);
    Procedure CheckEnable;
    Property CurPage: Integer Read FCurPage Write SetCurPage;
  Public
    Zoom: Double;
    Constructor CreateIt (AOwner: TComponent; AViewer: ThtmlViewer; Var Abort: Boolean);
  End;

Implementation

{$R *.DFM}
{$R GRID.RES}

Uses PrnForm;

Constructor TPreviewForm.CreateIt (AOwner: TComponent; AViewer: ThtmlViewer;
  Var Abort: Boolean);
Var
  StatusForm: TPrnStatusForm;
Begin
  Inherited Create (AOwner);
  ZoomBox.ItemIndex := 0;
  Screen.Cursors [crZoom] := LoadCursor (HInstance, 'ZOOM_CURSOR');
  Screen.Cursors [crHandDrag] := LoadCursor (HInstance, 'HAND_CURSOR');
  ZoomCursorBtnClick (Nil);
  Viewer := AViewer;
  MFPrinter := TMetaFilePrinter.Create (Self);
  StatusForm := TPrnStatusForm.Create (Self);
  Try
    StatusForm.DoPreview (Viewer, MFPrinter, Abort);
  Finally
    StatusForm.Free;
  End;
End;

Procedure TPreviewForm.CloseButClick (Sender: TObject);
Begin
  Close;
End;

Procedure TPreviewForm.FormClose (Sender: TObject; Var Action: TCloseAction);
Begin
  Action := caFree;
  Application.OnHint := OldHint;
  MFPrinter.Free;
End;

Procedure TPreviewForm.ScrollBoxResize (Sender: TObject);
Const
  BORD = 20;
Var
  z: Double;
  tmp: Integer;
  TotWid: Integer;
Begin
  Case ZoomBox.ItemIndex Of
    0: FitPageBtn.Down := True;
    1: FitWidthBtn.Down := True;
  Else Begin
    FitPageBtn.Down := False;
    FitWidthBtn.Down := False;
  End;
End;

	If ZoomBox.ItemIndex = -1 Then
		ZoomBox.ItemIndex := 0;

	Case ZoomBox.ItemIndex Of
		0: z := ((ScrollBox.ClientHeight - BORD) / PixelsPerInch) /
			 (MFPrinter.PaperHeight / MFPrinter.PixelsPerInchY);
		1: z := ((ScrollBox.ClientWidth - BORD) / PixelsPerInch) /
			 (MFPrinter.PaperWidth / MFPrinter.PixelsPerInchX);
		2: z := Zoom;
		3: z := 0.25;
		4: z := 0.50;
		5: z := 0.75;
		6: z := 1.00;
		7: z := 1.25;
		8: z := 1.50;
		9: z := 2.00;
		10: z := 3.00;
		11: z := 4.00;
	Else
		z := 1;
	End;

	If ZoomBox.ItemIndex <> 0 Then OnePageBtn.Down := True;

	PagePanel.Height := Trunc (PixelsPerInch * z * MFPrinter.PaperHeight /
		MFPrinter.PixelsPerInchY);
	PagePanel.Width := Trunc (PixelsPerInch * z * MFPrinter.PaperWidth /
		MFPrinter.PixelsPerInchX);

	PagePanel2.Visible := TwoPageBtn.Down;
	If TwoPageBtn.Down Then Begin
		PagePanel2.Width := PagePanel.Width;
		PagePanel2.Height := PagePanel.Height;
	End;

	TotWid := PagePanel.Width + BORD;
	If TwoPageBtn.Down Then
		TotWid := TotWid + PagePanel2.Width + BORD;

	{ Resize the Contain Panel }
	tmp := PagePanel.Height + BORD;
	If tmp < ScrollBox.ClientHeight Then
		tmp := ScrollBox.ClientHeight - 1;
	ContainPanel.Height := tmp;

	tmp := TotWid;
	If tmp < ScrollBox.ClientWidth Then
		tmp := ScrollBox.ClientWidth - 1;
	ContainPanel.Width := tmp;

	{ Center the Page Panel }
	If PagePanel.Height + BORD < ContainPanel.Height Then
		PagePanel.Top := ContainPanel.Height Div 2 - PagePanel.Height Div 2
	Else
		PagePanel.Top := BORD Div 2;
	PagePanel2.Top := PagePanel.Top;

	If TotWid < ContainPanel.Width Then
		PagePanel.Left := ContainPanel.Width Div 2 - (TotWid - BORD) Div 2
	Else
		PagePanel.Left := BORD Div 2;
	PagePanel2.Left := PagePanel.Left + PagePanel.Width + BORD;

	{ Make sure the scroll bars are hidden if not needed }
	If (PagePanel.Width + BORD <= ScrollBox.Width) And
		 (PagePanel.Height + BORD <= ScrollBox.Height)
		Then Begin
		ScrollBox.HorzScrollBar.Visible := False;
		ScrollBox.VertScrollBar.Visible := False;
	End
	Else Begin
		ScrollBox.HorzScrollBar.Visible := True;
		ScrollBox.VertScrollBar.Visible := True;
	End;

	{ Set the Zoom Variable }
	Zoom := z;
	ZoomLabel.Caption := Format ('%1.0n', [z * 100]) + '%';
End;

Procedure TPreviewForm.DrawMetaFile (PB: TPaintBox; mf: TMetaFile);
Begin
  PB.Canvas.Draw (0, 0, mf);
End;

Procedure TPreviewForm.PBPaint (Sender: TObject);
Var
  PB: TPaintBox;
  Draw: Boolean;
  Page: Integer;
Begin
  PB := Sender As TPaintBox;

  If PB = PB1 Then Begin
    Draw := CurPage < MFPrinter.LastAvailablePage;
    Page := CurPage;
  End
  Else Begin
   { PB2 }
   Draw := TwoPageBtn.Down And (CurPage + 1 < MFPrinter.LastAvailablePage);
   Page := CurPage + 1;
  End;

  SetMapMode (PB.Canvas.Handle, MM_ANISOTROPIC);
  SetWindowExtEx (PB.Canvas.Handle, MFPrinter.PaperWidth, MFPrinter.PaperHeight, Nil);
  SetViewportExtEx (PB.Canvas.Handle, PB.Width, PB.Height, Nil);
  SetWindowOrgEx (PB.Canvas.Handle, -MFPrinter.OffsetX, -MFPrinter.OffsetY, Nil);
  If Draw Then
   DrawMetaFile (PB, MFPrinter.MetaFiles [Page]);
End;

Procedure TPreviewForm.OnHint (Sender: TObject);
Begin
  HintLabel.Caption := Application.Hint;
End;

Procedure TPreviewForm.FormShow (Sender: TObject);
Begin
  BorderStyle := bsSingle;
  WindowState := wsMaximized;
  CurPage := 0;
  OldHint := Application.OnHint;
  Application.OnHint := OnHint;
  CheckEnable;
End;

Procedure TPreviewForm.SetCurPage (Val: Integer);
Var
  tmp: Integer;
Begin
  FCurPage := Val;
  tmp := 0;
  If MFPrinter <> Nil Then
    tmp := MFPrinter.LastAvailablePage;
  CurPageLabel.Caption := Format ('Página %d de %d', [Val + 1, tmp]);
  PB1.Invalidate;
  PB2.Invalidate;
End;

Procedure TPreviewForm.ZoomBoxChange (Sender: TObject);
Begin
  ScrollBoxResize (Nil);
  ScrollBoxResize (Nil);
End;

Procedure TPreviewForm.TwoPageBtnClick (Sender: TObject);
Begin
  ZoomBox.ItemIndex := 0;
  ScrollBoxResize (Nil);
End;

Procedure TPreviewForm.NextPageBtnClick (Sender: TObject);
Begin
  CurPage := CurPage + 1;
  CheckEnable;
End;

Procedure TPreviewForm.PrevPageBtnClick (Sender: TObject);
Begin
  CurPage := CurPage - 1;
  CheckEnable;
End;

Procedure TPreviewForm.CheckEnable;
Begin
  NextPageBtn.Enabled := CurPage + 1 < MFPrinter.LastAvailablePage;
  PrevPageBtn.Enabled := CurPage > 0;

  NextPageSpeed.Enabled := NextPageBtn.Enabled;
  PrevPageSpeed.Enabled := PrevPageBtn.Enabled;

  FirstPageSpeed.Enabled := PrevPageBtn.Enabled;
  LastPageSPeed.Enabled := NextPageBtn.Enabled;
End;

Procedure TPreviewForm.FirstPageSpeedClick (Sender: TObject);
Begin
  CurPage := 0;
  CheckEnable;
End;

Procedure TPreviewForm.LastPageSpeedClick (Sender: TObject);
Begin
  CurPage := MFPrinter.LastAvailablePage - 1;
  CheckEnable;
End;

Procedure TPreviewForm.ZoomCursorBtnClick (Sender: TObject);
Begin
  PB1.Cursor := crZoom;
  PB2.Cursor := crZoom;
End;

Procedure TPreviewForm.HandCursorBtnClick (Sender: TObject);
Begin
  PB1.Cursor := crHandDrag;
  PB2.Cursor := crHandDrag;
End;

Procedure TPreviewForm.PB1MouseDown (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  sx, sy: Single;
  nx, ny: Integer;
Begin
  If ZoomCursorBtn.Down Then Begin
    sx := X / PagePanel.Width;
    sy := Y / PagePanel.Height;

    If ssLeft In Shift Then Zoom := Zoom * ZOOMFACTOR;
    If ssRight In Shift Then Zoom := Zoom / ZOOMFACTOR;
    ZoomBox.ItemIndex := 2;
    ScrollBoxResize (Nil);

    nx := Trunc (sx * PagePanel.Width);
    ny := Trunc (sy * PagePanel.Height);
    ScrollBox.HorzScrollBar.Position := nx - ScrollBox.Width Div 2;
    ScrollBox.VertScrollBar.Position := ny - ScrollBox.Height Div 2;
  End;

  If HandCursorBtn.Down Then Begin
    DownX := X;
    DownY := Y;
    Moving := True;
  End;
End;

Procedure TPreviewForm.PB1MouseMove (Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
Begin
  If Moving Then Begin
    ScrollBox.HorzScrollBar.Position := ScrollBox.HorzScrollBar.Position + (DownX - X);
    ScrollBox.VertScrollBar.Position := ScrollBox.VertScrollBar.Position + (DownY - Y);
  End;
End;

Procedure TPreviewForm.PB1MouseUp (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Begin
  Moving := False;
End;

Procedure TPreviewForm.PrintBtnClick (Sender: TObject);
Var
  StatusForm: TPrnStatusForm;
  Dummy: Boolean;
Begin
  With PrintDialog1, MFPrinter Do Begin
    MaxPage := LastAvailablePage;
    ToPage := LastAvailablePage;
    Options := [poPageNums];
    StatusForm := TPrnStatusForm.Create (Self);
    If Execute Then
      If PrintRange = prAllPages Then
      	StatusForm.DoPrint (Viewer, FromPage, LastAvailablePage, Dummy)
      Else
      	StatusForm.DoPrint (Viewer, FromPage, ToPage, Dummy);
      StatusForm.Free;
  End;
End;

Procedure TPreviewForm.OnePageBtnMouseUp (Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Begin
  ZoomBox.ItemIndex := 0;
  ScrollBoxResize (Nil);
End;

Procedure TPreviewForm.FitPageBtnClick (Sender: TObject);
Begin
  ZoomBox.ItemIndex := 0;
  ZoomBoxChange (Nil);
End;

Procedure TPreviewForm.FitWidthBtnClick (Sender: TObject);
Begin
  ZoomBox.ItemIndex := 1;
  ZoomBoxChange (Nil);
End;

Procedure TPreviewForm.CloseBtnClick (Sender: TObject);
Begin
  Close;
End;

End.

