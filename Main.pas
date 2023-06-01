Unit Main;

Interface

Uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, FramView, ExtCtrls, StdCtrls, Menus, MMSystem, IniFiles,
  Clipbrd, HTMLsubs, HTMLun2, HTMLView, ShellAPI, MPlayer, Readhtml,
  FramBrwz, ComCtrls, ImgList, ToolWin;

Const
  MaxHistories = 8;  { Size of History list }

Type
  TMainForm = Class (TForm)
    FrameViewer: TFrameViewer;
    MediaPlayer: TMediaPlayer;
    PopupMenu: TPopupMenu;
    ViewImageItem: TMenuItem;
    CopyImageToClipboardItem: TMenuItem;
    N5: TMenuItem;
    CopyLinkToClipboardItem: TMenuItem;
    N6: TMenuItem;
    OpenInNewWindowItem: TMenuItem;
    FindDialog: TFindDialog;
    MainMenu: TMainMenu;
    FileMenu: TMenuItem;
    FileOpenInNewWindowItem: TMenuItem;
    FileOpenItem: TMenuItem;
    N4: TMenuItem;
    FilePrintItem: TMenuItem;
    FilePrintPreviewItem: TMenuItem;
    FilePageSetupItem: TMenuItem;
    MenuItem1: TMenuItem;
    FileExitItem: TMenuItem;
    EditMenu: TMenuItem;
    EditCopyItem: TMenuItem;
    MenuItem2: TMenuItem;
    EditSelectAllItem: TMenuItem;
    SearchMenu: TMenuItem;
    SearchFindItem: TMenuItem;
    OptionsMenu: TMenuItem;
    OptionsImagesItem: TMenuItem;
    OptionsFontsItem: TMenuItem;
    HelpMenu: TMenuItem;
    HelpIndexItem: TMenuItem;
    MenuItem3: TMenuItem;
    HelpAboutItem: TMenuItem;
    OpenDialog: TOpenDialog;
    StatusLine: TStatusBar;
    ImageList: TImageList;
    PrintDialog: TPrintDialog;
    PageSetupDialog: TPageSetupDialog;
    CoolBar: TCoolBar;
    ToolBar: TToolBar;
    OpenButton: TToolButton;
    PrintButton: TToolButton;
    PrintPreviewButton: TToolButton;
    ToolBarSep2: TToolButton;
    ReloadButton: TToolButton;
    BackButton: TToolButton;
    FwdButton: TToolButton;
    ToolBarSep3: TToolButton;
    CopyButton: TToolButton;
    SearchButton: TToolButton;
    FontButton: TToolButton;
    ToolBarSep1: TToolButton;
    HelpButton: TToolButton;
    AboutButton: TToolButton;
    ExitButton: TToolButton;
    TopPanel: TPanel;
    BoxCaption: TLabel;
    ProgramIcon: TImage;
    HistoryComboBox: TComboBox;
    Procedure DisplayHint (Sender: TObject);
    Procedure OpenFileItemClick (Sender: TObject);
    Procedure OptionsImagesItemClick (Sender: TObject);
    Procedure ReloadButtonClick (Sender: TObject);
    Procedure FormCreate (Sender: TObject);
    Procedure FormDestroy (Sender: TObject);
    Procedure HistoryChange (Sender: TObject);
    Procedure FileExitItemClick (Sender: TObject);
    Procedure FontChangeClick (Sender: TObject);
    Procedure FilePrintItemClick (Sender: TObject);
    Procedure FormShow (Sender: TObject);
    Procedure SearchFindItemClick (Sender: TObject);
    Procedure FindDialogFind (Sender: TObject);
    Procedure ProcessingHandler (Sender: TObject; ProcessingOn: Boolean);
    Procedure HelpAboutItemClick (Sender: TObject);
    Procedure HelpIndexItemClick (Sender: TObject);
    Procedure EditCopyItemClick (Sender: TObject);
    Procedure EditMenuClick (Sender: TObject);
    Procedure EditSelectAllItemClick (Sender: TObject);
    Procedure FormCloseQuery (Sender: TObject; Var CanClose: Boolean);
    Procedure HotSpotTargetCovered (Sender: TObject; Const Target, URL: String);
    Procedure HotSpotTargetClick (Sender: TObject; Const Target, URL: String; Var Handled: Boolean);
    Procedure WindowRequest (Sender: TObject; Const Target, URL: String);
    Procedure FormResize (Sender: TObject);
    Procedure FormClose (Sender: TObject; Var Action: TCloseAction);
    Procedure CopyLinkToClipboardItemClick (Sender: TObject);
    Procedure PrintFooter (Sender: TObject; Canvas: TCanvas; NumPage, W, H: Integer; Var StopPrinting: Boolean);
    Procedure PrintHeader (Sender: TObject; Canvas: TCanvas; NumPage, W, H: Integer; Var StopPrinting: Boolean);
    Procedure BackButtonClick (Sender: TObject);
    Procedure FwdButtonClick (Sender: TObject);
    Procedure CopyImageToClipboardClick (Sender: TObject);
    Procedure ImageClick (Sender, Obj: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    Procedure ViewImageClick (Sender: TObject);
    Procedure FileMenuClick (Sender: TObject);
    Procedure ImageOver (Sender, Obj: TObject; Shift: TShiftState; X, Y: Integer);
    Procedure HistoryComboBoxChange (Sender: TObject);
    Procedure SubmitEvent (Sender: TObject; Const AnAction, Target, EncType, Method: String; Results: TStringList);
    Procedure FilePrintPreviewItemClick (Sender: TObject);
    Procedure FilePageSetupItemClick (Sender: TObject);
    Procedure OpenInNewWindowClick (Sender: TObject);
    Procedure MediaPlayerNotify (Sender: TObject);
    Procedure SoundRequest (Sender: TObject; Const SRC: String; Loop: Integer; Terminate: Boolean);
    Procedure FormKeyDown (Sender: TObject; Var Key: Word; Shift: TShiftState);
    Function FormHelp(Command: Word; Data: Integer; var CallHelp: Boolean): Boolean;
  Private
    { Private declarations }
    NumPages: Integer;
    CurrentURL: String;
    FoundObject: TImageObj;
    NewWindowFile: String;
    MediaCount: Integer;
    ThePlayer: TObject;
    WindowCount: Integer;
    Function FindString (Const SearchKey: String; SearchList: TStrings): Integer;
    Procedure wmDropFiles (Var Message: TMessage); Message wm_DropFiles;
    Procedure UpdateMenuItems (Sender: TObject);
  Public
   { Public declarations }
  End;

Var
  MainForm: TMainForm;
  FileList: TStringList;

Implementation

{$R *.DFM}

Uses
  AboutDlg, Submit, FontDlg, ImgForm, PrvForm, XMLFrm, HtmlHelpAPI;

Function TMainForm.FindString (Const SearchKey: String; SearchList: TStrings): Integer;
{ Search for an item in a string list }
Var
  Found: Boolean;
  I: Integer;
  SearchStr: String;
Begin
  Found := False;
  I := 0;
  While (I < SearchList.Count) And (Not Found) Do Begin
    SearchStr := SearchList.Strings [I];
    If (Pos (SearchKey, SearchStr) <> 0) Then Begin
      Result := I;
      Found := True;
      Exit;
    End;
    Inc (I);
  End;
  If Not Found Then Result := -1;
End;

Procedure TMainForm.wmDropFiles (Var Message: TMessage);
Var
  S: String [200];
  Count: Integer;
  AForm: TXMLForm;
Begin
  Count := DragQueryFile (Message.WParam, 0, @S[1], 200);
  Length (S) := Count;
  DragFinish (Message.WParam);
  If Count > 0 Then Begin
    If (CompareText (S, '.xml') = 0) Then Begin
      AForm := TXMLForm.Create (Self);
      With AForm Do Begin
        Caption := '';
        ReadFile (Trim (S));
        Show;
      End;
    End
    Else Begin
      FrameViewer.Visible := True;
      FrameViewer.LoadFromFile (S);
    End;
  End;
  Message.Result := 0;
End;

Procedure TMainForm.DisplayHint (Sender: TObject);
Begin
  StatusLine.Panels [0].Text := Application.Hint;
End;

Procedure TMainForm.FormCreate (Sender: TObject);
Var
  I: Integer;
  IniFile: TIniFile;
Begin
  WindowCount := 0;
  DragAcceptFiles (Handle, True);
  Application.OnHint := DisplayHint;
  Screen.OnActiveControlChange := UpdateMenuItems;
  FileList := TStringList.Create;
  FileList.Duplicates := dupIgnore;
  FileList.Sorted := True;
  IniFile := TIniFile.Create (ChangeFileExt (ExtractFileName (Application.ExeName), '.INI'));

  Left := IniFile.ReadInteger('MainWindow', 'Left', Left);
  Top := IniFile.ReadInteger('MainWindow', 'Top', Top);
  Width := IniFile.ReadInteger('MainWindow', 'Width', Width);
  Height := IniFile.ReadInteger('MainWindow', 'Height', Height);
  WindowState := TWindowState(IniFile.ReadInteger('MainWindow', 'State',
    integer(WindowState)));

  With FrameViewer Do Begin
    DefFontName := IniFile.ReadString ('Fonts', 'Name', 'Arial');
    DefFontSize := IniFile.ReadInteger ('Fonts', 'Size', 12);
    DefFontColor := IniFile.ReadInteger ('Colors', 'Foreground', clBtnText);
    DefBackground := IniFile.ReadInteger ('Colors', 'Background', clBtnFace);
    DefHotSpotColor := IniFile.ReadInteger ('Colors', 'HotSpots', clBlue);
    ViewImages := IniFile.ReadBool ('Options', 'Images', True);
    HistoryMaxCount := MaxHistories;	{ Defines size of history list }
    Visible := False;
  End;

  ChDir (IniFile.ReadString ('History', 'Last Folder', ExtractFilePath (ParamStr (0))));
  OptionsImagesItem.Checked := FrameViewer.ViewImages;
  IniFile.Free;
End;

Procedure TMainForm.FormShow (Sender: TObject);
Var
  S: String;
  I: Integer;
  AForm: TXMLForm;
Begin
  If (ParamCount >= 1) Then Begin { Parameter is file to load }
    S := CmdLine;
    I := Pos ('" ', S);
    If I > 0 Then
      Delete (S, 1, I + 1) { Delete EXE name in quotes }
    Else
      Delete (S, 1, Length (ParamStr (0))); { In case no quote marks }
    I := Pos ('"', S);
    While I > 0 Do Begin { Remove any quotes from parameter }
      Delete (S, I, 1);
      I := Pos ('"', S);
    End;
    If (CompareText (S, '.xml') = 0) Then Begin
      AForm := TXMLForm.Create (Self);
      With AForm Do Begin
        Caption := '';
        ReadFile (Trim (S));
        Show;
      End;
    End
    Else Begin
      FrameViewer.Visible := True;
      FrameViewer.LoadFromFile (HtmlToDos (Trim (S)));
    End;
  End;
End;

Procedure TMainForm.FormDestroy (Sender: TObject);
Var
  S: String;
  IniFile: TIniFile;
Begin
  GetDir (0, S);
  IniFile := TIniFile.Create (ChangeFileExt (ExtractFileName (Application.ExeName), '.INI'));

  IniFile.WriteInteger('MainWindow', 'Left', Left);
  IniFile.WriteInteger('MainWindow', 'Top', Top);
  IniFile.WriteInteger('MainWindow', 'Width', Width);
  IniFile.WriteInteger('MainWindow', 'Height', Height);
  IniFile.WriteInteger('MainWindow', 'State', integer(WindowState));

  With FrameViewer Do Begin
    IniFile.WriteString ('Fonts', 'Name', DefFontName);
    IniFile.WriteInteger ('Fonts', 'Size', DefFontSize);
    IniFile.WriteInteger ('Colors', 'Foreground', DefFontColor);
    IniFile.WriteInteger ('Colors', 'Background', DefBackground);
    IniFile.WriteInteger ('Colors', 'HotSpots', DefHotSpotColor);
    IniFile.WriteBool ('Options', 'Images', ViewImages);
    IniFile.WriteString ('History', 'Last Folder', S);
  End;

  Screen.OnActiveControlChange := Nil;
  FileList.Free;
  IniFile.Free;
End;

Procedure TMainForm.UpdateMenuItems (Sender: TObject);
Begin
  With FrameViewer Do Begin
    FwdButton.Enabled := FwdButtonEnabled;
    BackButton.Enabled := BackButtonEnabled;
    ReloadButton.Enabled := CurrentFile <> '';
    PrintButton.Enabled := CurrentFile <> '';
    PrintPreviewButton.Enabled := CurrentFile <> '';
    CopyButton.Enabled := (CurrentFile <> '');
    SearchButton.Enabled := CurrentFile <> '';
    FontButton.Enabled := CurrentFile <> '';
    FilePrintItem.Enabled := CurrentFile <> '';
    FilePrintPreviewItem.Enabled := CurrentFile <> '';
    FilePageSetupItem.Enabled := CurrentFile <> '';
    SearchFindItem.Enabled := CurrentFile <> '';
    EditSelectAllItem.Enabled := CurrentFile <> '';
    EditCopyItem.Enabled := (CurrentFile <> '');
    OptionsFontsItem.Enabled := CurrentFile <> '';
    OptionsImagesItem.Enabled := CurrentFile <> '';
    FileOpenInNewWindowItem.Enabled := CurrentFile <> '';
    FileOpenItem.Enabled := True;
  End;
End;

Procedure TMainForm.HotSpotTargetClick (Sender: TObject; Const Target, URL: String; Var Handled: Boolean);
 { This routine handles what happens when a hot spot is clicked. The assumption
 is made that DOS filenames are being used. .EXE, .WAV, .MID, and .AVI files are
 handled here, but other file types could be easily added.
 If the URL is handled here, set Handled to True. If not handled here, set it
 to False and TFrameViewer will handle it. }
Const
  snd_Async = $0001;	{ play asynchronously }
Var
  PC: Array [0..255] Of Char;
  S, Params: String [255];
  Ext: String [5];
  I, J, K: Integer;
Begin
  Handled := False;
  I := Pos (':', URL);
  J := Pos ('file:', LowerCase (URL));
  If (I <= 2) Or (J > 0) Then Begin { Apparently the URL is a filename }
    S := URL;
    K := Pos (' ', S); { Look for parameters }
    If K = 0 Then K := Pos ('?', S); { Could be '?x,y', etc. }
    If K > 0 Then Begin
      Params := Copy (S, K + 1, 255); { Save any parameters }
      S [0] := Chr (K - 1); { Truncate S }
    End
    Else Params := '';
    S := (Sender As TFrameViewer).HTMLExpandFileName (S);
    Ext := UpperCase (ExtractFileExt (S));
    If Ext = '.WAV' Then Begin
      Handled := True;
      sndPlaySound (StrPCopy (PC, S), snd_ASync);
    End
    Else If Ext = '.EXE' Then Begin
      Handled := True;
      WinExec (StrPCopy (PC, S + ' ' + Params), sw_Show);
    End
    Else If (Ext = '.MID') Or (Ext = '.AVI') Then Begin
      Handled := True;
      WinExec (StrPCopy (PC, 'MPlayer.exe /play /close ' + S), sw_Show);
    End;
    { Else ignore other extensions }
    Exit;
  End;
  { Other protocall, mailto:, ftp:, etc.}
  I := Pos ('mailto:', LowerCase (URL));
  J := Pos ('http://', LowerCase (URL));
  If (I > 0) Or (J > 0) Then Begin
    { Note: ShellExecute causes problems when run from Delphi 4 IDE }
    ShellExecute (Handle, Nil, StrPCopy (PC, URL), Nil, Nil, sw_ShowNormal);
    Handled := True;
    Exit;
  End;
End;

Procedure TMainForm.HotSpotTargetCovered (Sender: TObject; Const Target, URL: String);
{ Mouse moved over or away from a hot spot. Change the status line }
Var
  S, Dest: String;
  I: Integer;
Begin
  If URL = '' Then Begin
    //CopyLinkToClipboardItem.Enabled := False;
    //OpenInNewWindowItem.Enabled := False;
    StatusLine.Panels [0].Text := 'Loris';
    PopupMenu.AutoPopup := False;
  End
  Else Begin
    CurrentURL := URL;
    S := URL;
    I := Pos ('#', S);
    If I >= 1 Then Begin
      Dest := System.Copy (S, I, 255); { Local destination }
      S := System.Copy (S, 1, I - 1); { The file name }
    End
    Else Dest := ''; { No local destination }
    If S = '' Then S := FrameViewer.CurrentFile
    Else S := FrameViewer.HTMLExpandFileName (S);
    NewWindowFile := S + Dest;
    OpenInNewWindowItem.Enabled := FileExists (S);
    ViewImageItem.Enabled := False;
    CopyImageToClipboardItem.Enabled := False;
    CopyLinkToClipboardItem.Enabled := True;
    If Target <> '' Then
      StatusLine.Panels [0].Text := 'Target: ' + Target + '  Atalho para ' + URL
    Else
      StatusLine.Panels [0].Text := 'Atalho para ' + URL;
      PopupMenu.AutoPopup := True;
    End;
End;

Procedure TMainForm.OpenFileItemClick (Sender: TObject);
Var
  AForm: TXMLForm;
Begin
  If OpenDialog.Execute Then Begin
    If (CompareText (ExtractFileExt (OpenDialog.Filename), '.xml') = 0) Then Begin
      AForm := TXMLForm.Create (Self);
      With AForm Do Begin
        Caption := '';
        ReadFile (OpenDialog.Filename);
        Show;
      End;
    End
    Else Begin
      FrameViewer.Visible := True;
      FrameViewer.LoadFromFile (OpenDialog.Filename);
      Caption := FrameViewer.DocumentTitle;
    End;
    FileList.Add (LowerCase (OpenDialog.Filename));
    OpenDialog.HistoryList := FileList;
  End;
End;

Procedure TMainForm.OptionsImagesItemClick (Sender: TObject);
{ The Show Images menu item was clicked }
Begin
  With FrameViewer Do Begin
    ViewImages := Not ViewImages;
    (Sender As TMenuItem).Checked := ViewImages;
  End;
End;

Procedure TMainForm.ReloadButtonClick (Sender: TObject);
{ The Reload button was clicked }
Begin
  With FrameViewer Do Begin
    ReloadButton.Enabled := False;
    Reload; { Load again }
    ReloadButton.Enabled := CurrentFile <> '';
    SetFocus;
  End;
End;

Procedure TMainForm.HistoryChange (Sender: TObject);
{ This event occurs when something changes history list }
Var
  I, Choice: Integer;
  Cap: String [255];
Begin
  With Sender As TFrameViewer Do Begin
    { Check to see which buttons are to be enabled }
    FwdButton.Enabled := FwdButtonEnabled;
    BackButton.Enabled := BackButtonEnabled;

    { Enable and caption the appropriate history menuitems }
    For I := 0 To MaxHistories - 1 Do Begin
      If I < History.Count Then Begin
        Cap := History.Strings [I];
        If TitleHistory [I] <> '' Then
        Cap := Cap + '--' + TitleHistory [I];
        Caption := Cap; { Cap limits string to 80 chars }
	Visible := True;
        Choice := FindString (Cap, HistoryComboBox.Items);
        If Choice < 0 Then HistoryComboBox.Items.Insert (I, Cap);
        HistoryComboBox.ItemIndex := HistoryIndex;
      End
    End;
    Caption := DocumentTitle; { Keep the caption updated }
    FrameViewer.SetFocus;
  End;
End;

Procedure TMainForm.HistoryComboBoxChange (Sender: TObject);
Begin
  { Changing the HistoryIndex loads and positions the appropriate document }
  FrameViewer.HistoryIndex := HistoryComboBox.ItemIndex;
End;

Procedure TMainForm.FileExitItemClick (Sender: TObject);
Begin
  Close;
End;

Procedure TMainForm.FontChangeClick (Sender: TObject);
Var
  FontForm: TFontForm;
Begin
  FontForm := TFontForm.Create (Self);
  Try
    With FontForm Do Begin
      FontName := FrameViewer.DefFontName;
      FontColor := FrameViewer.DefFontColor;
      FontSize := FrameViewer.DefFontSize;
      HotSpotColor := FrameViewer.DefHotSpotColor;
      Background := FrameViewer.DefBackground;
      If ShowModal = mrOk Then Begin
        Screen.Cursor := crHourGlass;
      	FrameViewer.DefFontName := FontName;
      	FrameViewer.DefFontColor := FontColor;
        FrameViewer.DefFontSize := FontSize;
      	FrameViewer.DefHotSpotColor := HotSpotColor;
      	FrameViewer.DefBackground := Background;
      	ReloadButtonClick (Self); { reload to see how it looks }
        Screen.Cursor := crDefault;
      End;
    End;
    Finally
      FontForm.Free;
    End;
End;

Procedure TMainForm.FilePrintItemClick (Sender: TObject);
Begin
  With PrintDialog Do
    If Execute Then
      If PrintRange = prAllPages Then
      	FrameViewer.Print (1, 9999)
      Else
        FrameViewer.Print (FromPage, ToPage);
End;

Procedure TMainForm.SearchFindItemClick (Sender: TObject);
Begin
  FindDialog.Position := Point (150, 150);
  FindDialog.Execute;
End;

Procedure TMainForm.FindDialogFind (Sender: TObject);
Begin
  With FindDialog Do Begin
    If Not FrameViewer.Find (FindText, frMatchCase In Options) Then Begin
      MessageBeep (mb_IconInformation);
      Application.MessageBox ('Texto não encontrado!', 'Informação', mb_Ok Or mb_IconInformation);
    End;
  End;
End;

Procedure TMainForm.ProcessingHandler (Sender: TObject; ProcessingOn: Boolean);
Begin
  If ProcessingOn Then Begin
    { Disable various buttons and menu items during processing }
    FwdButton.Enabled := False;
    BackButton.Enabled := False;
    ReloadButton.Enabled := False;
    PrintButton.Enabled := False;
    PrintPreviewButton.Enabled := False;
    //CopyButton.Enabled := False;
    SearchButton.Enabled := False;
    FilePrintItem.Enabled := False;
    FilePrintPreviewItem.Enabled := False;
    FilePageSetupItem.Enabled := False;
    SearchFindItem.Enabled := False;
    //EditCopyItem.Enabled := False;
    EditSelectAllItem.Enabled := False;
    FileOpenItem.Enabled := False;
    FileOpeninNewWindowItem.Enabled := False;
  End
  Else Begin
    FwdButton.Enabled := FrameViewer.FwdButtonEnabled;
    BackButton.Enabled := FrameViewer.BackButtonEnabled;
    ReloadButton.Enabled := FrameViewer.CurrentFile <> '';
    PrintButton.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil);
    PrintPreviewButton.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil);
    //CopyButton.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.SelLength <> 0);
    SearchButton.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil);
    FilePrintItem.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil);
    FilePrintPreviewItem.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil);
    FilePageSetupItem.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil);
    SearchFindItem.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil);
    EditSelectAllItem.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil);
    //EditCopyItem.Enabled := (FrameViewer.CurrentFile <> '') And (FrameViewer.ActiveViewer <> Nil) And (FrameViewer.SelLength <> 0);
    FileOpenItem.Enabled := True;
    FileOpenInNewWindowItem.Enabled := True;
  End;
End;

Procedure TMainForm.FwdButtonClick (Sender: TObject);
Begin
  FrameViewer.GoFwd;
End;

Procedure TMainForm.BackButtonClick (Sender: TObject);
Begin
  FrameViewer.GoBack;
End;

Procedure TMainForm.HelpAboutItemClick (Sender: TObject);
Begin
  AboutBox := TAboutBox.Create (Self);
  Try
    AboutBox.ShowModal;
  Finally
    AboutBox.Free;
  End;
End;

Procedure TMainForm.HelpIndexItemClick (Sender: TObject);
Begin
  HtmlHelpShowContents;
End;

Procedure TMainForm.EditCopyItemClick (Sender: TObject);
Var
  Result: Integer;
Begin
  If FrameViewer.SelLength = 0 Then Exit;
  Result := id_Ok;
  If FrameViewer.SelLength > 32000 Then Begin
    MessageBeep (mb_IconExclamation);
    Result := Application.MessageBox ('O texto selecionado é muito extenso e poderá ser truncado!',
     'Aviso', mb_OkCancel Or mb_IconExclamation);
  End;

  If Result = id_Ok Then Begin
    FrameViewer.CopyToClipboard;
    MessageBeep (mb_IconInformation);
    Application.MessageBox ('Texto copiado para a Área de Transferência',
      'Informação', mb_Ok Or mb_IconInformation);
  End;
End;

Procedure TMainForm.EditMenuClick (Sender: TObject);
Begin
  With FrameViewer Do Begin
    EditCopyItem.Enabled := SelLength <> 0;
    CopyButton.Enabled := SelLength <> 0;
    EditSelectAllItem.Enabled := (ActiveViewer <> Nil) And (ActiveViewer.CurrentFile <> '');
  End;
End;

Procedure TMainForm.EditSelectAllItemClick (Sender: TObject);
Begin
  FrameViewer.SelectAll;
End;

Procedure TMainForm.FormCloseQuery (Sender: TObject; Var CanClose: Boolean);
Begin
  {MessageBeep (mb_IconQuestion);
  If Application.MessageBox ('Deseja encerrar o programa?',
   'Confirmação', mb_YesNo Or mb_IconQuestion) = id_Yes
  Then CanClose := True Else CanClose := False;}
End;

Procedure TMainForm.WindowRequest (Sender: TObject; Const Target, URL: String);
Var
  S, Dest: String [255];
  I: Integer;
  PC: Array [0..255] Of Char;
Begin
  S := URL;
  I := Pos ('#', S);
  If I >= 1 Then Begin
    Dest := System.Copy (S, I, 255); { Local destination }
    S := System.Copy (S, 1, I - 1); { The file name }
  End
  Else
    Dest := ''; { No local destination }
    S := FrameViewer.HTMLExpandFileName (S);
    If FileExists (S) Then
     WinExec (StrPCopy (PC, ParamStr (0) + ' "' + S + Dest + '"'), sw_Show);
End;

Procedure TMainForm.FormResize (Sender: TObject);
Begin
  { Prevent the status and toolbar from being hidden }
  If Width < 442 Then Width := 442;
  If Height < 145 Then Height := 145;
  HistoryComboBox.Width := (MainForm.Width - ProgramIcon.Width) - 100;
End;

Procedure TMainForm.FormClose (Sender: TObject; Var Action: TCloseAction);
Begin
  Action := caFree;
End;

Procedure TMainForm.CopyLinkToClipboardItemClick (Sender: TObject);
Begin
  Clipboard.AsText := CurrentURL;
End;

Procedure TMainForm.CopyImageToClipboardClick (Sender: TObject);
Begin
  Clipboard.Assign (FoundObject.Bitmap);
End;

Procedure TMainForm.PrintFooter (Sender: TObject; Canvas: TCanvas;
  NumPage, W, H: Integer; Var StopPrinting: Boolean);
Var
  AFont: TFont;
Begin
  AFont := TFont.Create;
  AFont.Name := FrameViewer.DefFontName;
  AFont.Size := FrameViewer.DefFontSize - 2 {8};
  With Canvas Do Begin
    Font.Assign (AFont);
    SetTextAlign (Handle, TA_Bottom Or TA_Left);
    TextOut (50, 40, {LeftFooter} DateToStr (Date));
    SetTextAlign (Handle, TA_Bottom Or TA_Right);
    TextOut (W - 50, 40, {RightFooter} 'Página ' + IntToStr (NumPage) + ' de ' + IntToStr (NumPages));
  End;
  AFont.Free;
End;

Procedure TMainForm.PrintHeader (Sender: TObject; Canvas: TCanvas;
  NumPage, W, H: Integer; Var StopPrinting: Boolean);
Var
  AFont: TFont;
Begin
  AFont := TFont.Create;
  AFont.Name := FrameViewer.DefFontName;
  AFont.Size := FrameViewer.DefFontSize - 2 {8};
  With Canvas Do Begin
    Font.Assign (AFont);
    SetBkMode (Handle, Transparent);
    SetTextAlign (Handle, TA_Top Or TA_Left);
    If FrameViewer.ActiveViewer <> Nil Then Begin
      TextOut (50, 40, {LeftHeader} FrameViewer.ActiveViewer.DocumentTitle);
      SetTextAlign (Handle, TA_Top Or TA_Right);
      TextOut (W - 50, 40, {RightHeader} ExtractFileName (FrameViewer.ActiveViewer.CurrentFile));
    End;
  End;
  AFont.Free;
End;

Procedure TMainForm.ViewImageClick (Sender: TObject);
Var
  AForm: TImageForm;
Begin
  AForm := TImageForm.Create (Self);
  With AForm Do Begin
    ImageFormBitmap := FoundObject.Bitmap;
    Caption := '';
    Show;
  End;
End;

Procedure TMainForm.ImageClick (Sender, Obj: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Var
  Pt: TPoint;
Begin
  If Button = mbRight Then Begin
    If (Obj Is TImageObj) Then Begin
      FoundObject := TImageObj (Obj);
      CopyLinkToClipboardItem.Enabled := FoundObject.Bitmap = Nil;
      ViewImageItem.Enabled := FoundObject.Bitmap <> Nil;
      CopyImageToClipboardItem.Enabled := FoundObject.Bitmap <> Nil;
      GetCursorPos (Pt);
      PopupMenu.Popup (Pt.X, Pt.Y);
    End;
  End;
End;

Procedure TMainForm.FileMenuClick (Sender: TObject);
Begin
  FilePrintItem.Enabled := FrameViewer.ActiveViewer <> Nil;
  FilePrintPreviewItem.Enabled := FilePrintItem.Enabled;
End;

Procedure TMainForm.ImageOver (Sender, Obj: TObject;
  Shift: TShiftState; X, Y: Integer);
Begin
  If (Obj Is TImageObj) Then Begin
    FoundObject := TImageObj (Obj);
    CopyLinkToClipboardItem.Enabled := FoundObject.Bitmap = Nil;
    ViewImageItem.Enabled := FoundObject.Bitmap <> Nil;
    CopyImageToClipboardItem.Enabled := FoundObject.Bitmap <> Nil;
  End;
End;

Procedure TMainForm.SubmitEvent (Sender: TObject; Const AnAction, Target, EncType, Method: String; Results: TStringList);
Begin
  With SubmitForm Do Begin
    ActionText.Text := AnAction;
    MethodText.Text := Method;
    ResultBox.Items := Results;
    Results.Free;
    ShowModal;
  End;
End;

Procedure TMainForm.FilePrintPreviewItemClick (Sender: TObject);
Var
  pf: TPreviewForm;
  Viewer: ThtmlViewer;
  Abort: Boolean;
Begin
  Viewer := FrameViewer.ActiveViewer;
  If Assigned (Viewer) Then Begin
    pf := TPreviewForm.CreateIt (Self, Viewer, Abort);
    Try
      If Not Abort Then
      	pf.ShowModal;
    Finally
      pf.Free;
    End;
  End;
End;

Procedure TMainForm.FilePageSetupItemClick (Sender: TObject);
Begin
  With PageSetupDialog Do Begin
    If Execute Then Begin
      {FrameViewer.PrintMarginLeft := Margins.Left / 1000;
      FrameViewer.PrintMarginRight := Margins.Right / 1000;
      FrameViewer.PrintMarginTop := Margins.Top / 1000;
      FrameViewer.PrintMarginBottom := Margins.Bottom / 1000;}
     End;
   End;
   {With PageSetupDlg Do Begin
   Screen.Cursor := crHourGlass;
   NumPages := FrameViewer.NumPrinterPages;
   Screen.Cursor := crDefault;
   TopLeftEdit.Text := (FrameViewer.ActiveViewer.DocumentTitle);
   TopRightEdit.Text := ExtractFileName (FrameViewer.ActiveViewer.CurrentFile);
   BottomLeftEdit.Text := DateToStr (Date);
   BottomRightEdit.Text := 'Página 1 de ' + IntToStr (NumPages);
   If ShowModal = mrOk Then Begin
   LeftHeader := TopLeftEdit.Text;
   RightHeader := TopRightEdit.Text;
   LeftFooter := BottomLeftEdit.Text;
   RightFooter := BottomRightEdit.Text;
   End;
   End;}
End;

Procedure TMainForm.OpenInNewWindowClick (Sender: TObject);
Var
  PC: Array [0..255] Of Char;
Begin
  Inc (WindowCount);
  WinExec (StrPCopy (PC, ParamStr (0) + ' "' + NewWindowFile + '"'), sw_Show);
End;

Procedure TMainForm.MediaPlayerNotify (Sender: TObject);
Begin
  Try
    With MediaPlayer Do Begin
      If NotifyValue = nvSuccessful Then Begin
        If MediaCount > 0 Then Begin
	  Play;
	  Dec (MediaCount);
	End
	Else Begin
	  Close;
	  ThePlayer := Nil;
	End;
      End;
    End;
  Except
  End;
End;

Procedure TMainForm.SoundRequest (Sender: TObject; Const SRC: String;
  Loop: Integer; Terminate: Boolean);
Begin
  Try
    With MediaPlayer Do Begin
      If Terminate Then Begin
      	If (Sender = ThePlayer) Then Begin
          Close;
	  ThePlayer := Nil;
        End;
      End
      Else If ThePlayer = Nil Then Begin
      	If Sender Is ThtmlViewer Then
          Filename := ThtmlViewer (Sender).HTMLExpandFilename (SRC)
        Else Filename := (Sender As TFrameViewer).HTMLExpandFilename (SRC);
      	Notify := True;
      	Open;
      	ThePlayer := Sender;
        If Loop < 0 Then MediaCount := 9999
        Else If Loop = 0 Then MediaCount := 1
	Else MediaCount := Loop;
      End;
    End;
  Except
  End;
End;

Procedure TMainForm.FormKeyDown(Sender: TObject; Var Key: Word; Shift: TShiftState);
Begin
  If Key = VK_F5 Then Begin
    If FrameViewer.ActiveViewer <> Nil Then
      ReloadButtonClick (Self);
  End;
End;

Function TMainForm.FormHelp(Command: Word; Data: Integer;
  Var CallHelp: Boolean): Boolean;
Begin
   Result := (HtmlHelpShowHelp <> 0);
End;

End.
