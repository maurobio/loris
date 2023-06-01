unit MsgDlg;

interface

uses
  Classes, SysUtils, Graphics, Controls, Forms, Buttons, Dialogs, StdCtrls,
  ExtCtrls;
  
function MessageDialog(capt: string; Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): TModalResult;

implementation  

function MessageDialog(capt: string; Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgButtons; Captions: array of string): TModalResult;
var
  aMsgDlg: TForm;
  i: Integer;
  dlgButton: TBitBtn;
  CaptionIndex: Integer;
begin

  { Create the Dialog }
  { Dialog erzeugen }
  
  aMsgDlg := CreateMessageDialog(Msg, DlgType, Buttons);
  try
    aMsgDlg.Caption:=capt;
    captionIndex := 0;

    { Loop through Objects in Dialog }
    { Über alle Objekte auf dem Dialog iterieren}

    for i := 0 to aMsgDlg.ComponentCount - 1 do
    begin

     { If the object is of type TButton, then }
     { Wenn es ein Button ist, dann...}

      if (aMsgDlg.Components[i] is TBitBtn) then
      begin
        dlgButton := TBitBtn(aMsgDlg.Components[i]);
        if CaptionIndex > High(Captions) then Break;

        { Give a new caption from our Captions array}
        { Schreibe Beschriftung entsprechend Captions array}

        dlgButton.Caption := Captions[CaptionIndex];
        Inc(CaptionIndex);
      end;
    end;
    Result := aMsgDlg.ShowModal;
  finally
    aMsgDlg.Free;
  end;
end;

end.