Unit AboutDlg;

Interface

Uses
  Windows, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
  ShellAPI;

Type
  TAboutBox = Class (TForm)
    Panel: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    FlagIcon: TImage;
    EMail: TLabel;
    City: TLabel;
    OKButton: TButton;
    URL: TLabel;
    Procedure OKButtonClick (Sender: TObject);
    procedure EmailClick(Sender: TObject);
    procedure URLClick(Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  End;

Var
  AboutBox: TAboutBox;

Implementation

{$R *.DFM}

Procedure TAboutBox.OKButtonClick (Sender: TObject);
Begin
  Close;
End;

Procedure TAboutBox.EmailClick(Sender: TObject);
Begin
  ShellExecute (Application.Handle, 'open', 'mailto:maurobio@gmail.com', nil, nil, SW_NORMAL);
End;

procedure TAboutBox.URLClick(Sender: TObject);
begin
  ShellExecute (Application.Handle, 'open', 'https://github.com/maurobio', nil, nil, SW_NORMAL);
end;

End.

