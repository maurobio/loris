Unit FontDlg;

Interface

Uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ColorGrd, HtmlView, Spin, Buttons;

Type
  TFontForm = Class (TForm)
    FontListBox: TListBox;
    FontColorGrid: TColorGrid;
    HotSpotColorGrid: TColorGrid;
    BackListBox: TListBox;
    FontViewer: THTMLViewer;
    FontSizeEdit: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    CancelButton: TButton;
    OKButton: TButton;
    Procedure FormCreate (Sender: TObject);
    Procedure FormShow (Sender: TObject);
    Procedure CancelButtonClick (Sender: TObject);
    Procedure HotSpotColorGridChange (Sender: TObject);
    Procedure FontColorGridChange (Sender: TObject);
    Procedure ListBoxClicks (Sender: TObject);
    Procedure CancelClick (Sender: TObject);
  Private
    { Private declarations }
    FFontColor: TColor;
    FHotSpotColor: TColor;
    FFontSize: Integer;
    InitialFontName: String;
    InitialFontSize: Integer;
    InitialFontColor: TColor;
    InitialHotSpotColor: TColor;
    InitialBackground: TColor;
    Procedure AddItem (Const Value: String);
    Function GetFontName: TFontName;
    Procedure SetFontName (Value: TFontName);
    Function GetBackground: TColor;
    Procedure SetBackground (Value: TColor);
    Procedure SetFontColor (Value: TColor);
    Procedure SetHotSpotColor (Value: TColor);
    Procedure SetFontSize (Value: Integer);
  Public
    { Public declarations }
    Property FontName: TFontName Read GetFontName Write SetFontName;
    Property Background: TColor Read GetBackground Write SetBackground;
    Property FontColor: TColor Read FFontColor Write SetFontColor;
    Property FontSize: Integer Read FFontSize Write SetFontSize;
    Property HotSpotColor: TColor Read FHotSpotColor Write SetHotSpotColor;
  End;

Var
  FontForm: TFontForm;

Implementation

{$R *.DFM}

Const
  ViewText: String =
    '<center><h1>Cabe&ccedil;alho</h1></center>' +
    '<ul>Texto Normal.' +
    '<li><a href=NoWhere>Hipertexto</a>' +
    '<li><b>Negrito</b>' +
    '<li><i>It&aacute;lico</i>' +
    '<li><code>Bloco de C&oacute;digo</code>' +
    '</ul>' +
    '<hr>';

Procedure TFontForm.FormCreate (Sender: TObject);
Begin
  FontListBox.Items := Screen.Fonts;
  GetColorValues (AddItem);
  FontViewer.LoadFromBuffer (@ViewText [1], Length (ViewText));
End;

Procedure TFontForm.AddItem (Const Value: String);
Var
  Color: TColor;
Begin
  Color := StringToColor (Value);
  If (Color >= 0) Or (Color = -16) Or (Color = -6) Or (Color = -2) Then
    BackListBox.Items.Add (Value);
End;

Function TFontForm.GetFontName: TFontName;
Begin
  Try
    Result := FontListBox.Items [FontListBox.ItemIndex];
  Except
    Result := 'System'; { in case nothing hilited }
  End;
End;

Procedure TFontForm.SetFontName (Value: TFontName);
Var
  I: Integer;
Begin
  I := FontListBox.Items.IndexOf (Value);
  If I < 0 Then
    I := FontListBox.Items.IndexOf ('System');
  FontListBox.ItemIndex := I;
  FontViewer.DefFontName := Value;
End;

Function TFontForm.GetBackground: TColor;
Begin
  Try
    Result := StringToColor (BackListBox.Items [BackListBox.ItemIndex]);
  Except
    Result := clBtnFace;
  End;
End;

Procedure TFontForm.SetBackground (Value: TColor);
Var
  I: Integer;
  S: String [80];
Begin
  S := ColorToString (Value);
  I := BackListBox.Items.IndexOf (S);
  If I < 0 Then Begin
    BackListBox.Items.Add (S);
    I := BackListBox.Items.IndexOf (S);
  End;
  BackListBox.ItemIndex := I;
  FontViewer.DefBackground := Value;
End;

Procedure TFontForm.SetFontSize (Value: Integer);
Begin
  FontViewer.DefFontSize := Value;
  FFontSize := Value;
  FontSizeEdit.Value := Value;
End;

Procedure TFontForm.SetFontColor (Value: TColor);
Begin
  FontViewer.DefFontColor := Value;
  FFontColor := Value;
  FontColorGrid.ForegroundEnabled := False;
End;

Procedure TFontForm.SetHotSpotColor (Value: TColor);
Begin
  FontViewer.DefHotSpotColor := Value;
  FHotSpotColor := Value;
  HotSpotColorGrid.ForegroundEnabled := False;
End;

Procedure TFontForm.FormShow (Sender: TObject);
Begin
  InitialFontName := GetFontName;
  InitialFontColor := FFontColor;
  InitialHotSpotColor := FHotSpotColor;
  InitialBackground := GetBackground;
  InitialFontSize := FFontSize;
End;

Procedure TFontForm.CancelButtonClick (Sender: TObject);
Begin
  FontName := InitialFontName;
  FontSize := InitialFontSize;
  FontColor := InitialFontColor;
  HotSpotColor := InitialHotSpotColor;
  Background := InitialBackground;
End;

Procedure TFontForm.HotSpotColorGridChange (Sender: TObject);
Begin
  HotSpotColor := HotSpotColorGrid.ForegroundColor;
End;

Procedure TFontForm.FontColorGridChange (Sender: TObject);
Begin
  FontColor := FontColorGrid.ForegroundColor;
End;

Procedure TFontForm.ListBoxClicks (Sender: TObject);
Begin
  If Sender = FontListBox Then
    FontName := FontListBox.Items [FontListBox.ItemIndex]
  Else If Sender = BackListBox Then
    Background := StringToColor (BackListBox.Items [BackListBox.ItemIndex])
  Else If Sender = FontSizeEdit Then
    FontSize := FontSizeEdit.Value;
End;

Procedure TFontForm.CancelClick (Sender: TObject);
Begin
  Close;
End;

End.

