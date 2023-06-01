Unit Submit;

Interface

Uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

Type
  TSubmitForm = Class (TForm)
    ActionText: TEdit;
    MethodText: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ResultBox: TListBox;
    Label3: TLabel;
    CloseButton: TButton;
    Procedure CloseButtonClick (Sender: TObject);
  Private
    { Private declarations }
  Public
    { Public declarations }
  End;

Var
  SubmitForm: TSubmitForm;

Implementation

{$R *.DFM}

Procedure TSubmitForm.CloseButtonClick (Sender: TObject);
Begin
  Close;
End;

End.

