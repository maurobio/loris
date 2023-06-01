Program Loris;

Uses
  Forms,
  Main in 'Main.pas' {MainForm},
  Fontdlg in 'FONTDLG.PAS' {FontForm},
  PrnForm in 'PRNFORM.PAS' {PrnStatusForm},
  PrvForm in 'PRVFORM.PAS' {PreviewForm},
  ImgForm in 'IMGFORM.PAS' {ImageForm},
  AboutDlg in 'Aboutdlg.pas' {AboutBox},
  Submit in 'Submit.pas' {SubmitForm},
  XMLFrm in 'XMLFrm.pas' {XMLForm};

{$R *.RES}

Begin
  Application.Initialize;
  Application.Title := 'Loris';
  Application.HelpFile := 'Loris.chm';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TSubmitForm, SubmitForm);
  Application.CreateForm(TXMLForm, XMLForm);
  Application.Run;
End.
