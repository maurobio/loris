Unit XMLFrm;

Interface

Uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls, Menus, LibXmlParser, ImgList;

Type
  TXMLForm = Class (TForm)
    TreeView: TTreeView;
    XMLMenu: TMainMenu;
    FileMenu: TMenuItem;
    FileReturnItem: TMenuItem;
    NodeImageList: TImageList;
    Procedure FileReturnItemClick (Sender: TObject);
    Procedure FormCreate (Sender: TObject);
    Procedure FormDestroy (Sender: TObject);
  Private
    { Private declarations }
    XmlParser: TXmlParser;
  Public
    { Public declarations }
    CurNode: TTreeNode;
    Elements: TObjectList;
    CreateTree: Boolean;
    Procedure FillTree;
    Procedure ReadFile (Const Filename: String);
  End;

Var
  XMLForm: TXMLForm;

Implementation

{$R *.DFM}

Const
  Img_Tag = 0;
  Img_TagWithAttr = 1;
  Img_UndefinedTag = 2;
  Img_AttrDef = 3;
  Img_EntityDef = 4;
  Img_ParEntityDef = 5;
  Img_Text = 6;
  Img_Comment = 7;
  Img_PI = 8;
  Img_DTD = 9;
  Img_Notation = 10;
  Img_Prolog = 11;

Type
  TElementNode = Class
    Content: String;
    Attr: TStringList;
    Constructor Create (TheContent: String; TheAttr: TNvpList);
    Destructor Destroy; Override;
  End;

Constructor TElementNode.Create (TheContent: String; TheAttr: TNvpList);
Var
  I: Integer;
Begin
  Inherited Create;
  Content := TheContent;
  Attr := TStringList.Create;
  If TheAttr <> Nil Then
    For I := 0 To TheAttr.Count - 1 Do
      Attr.Add (TNvpNode (TheAttr[I]).Name + '=' + TNvpNode (TheAttr[I]).Value);
End;

Destructor TElementNode.Destroy;
Begin
  Attr.Free;
  Inherited Destroy;
End;

Procedure TXMLForm.FillTree;

  Procedure ScanElement (Parent: TTreeNode);
  Var
    Node: TTreeNode;
    Strg: String;
    EN: TElementNode;
  Begin
    While XmlParser.Scan Do Begin
      Node := Nil;
      Case XmlParser.CurPartType Of
        ptXmlProlog: Begin
            Node := TreeView.Items.AddChild (Parent, '<?xml?>');
            Node.ImageIndex := Img_Prolog;
            EN := TElementNode.Create (StrSFPas (XmlParser.CurStart, XmlParser.CurFinal), Nil);
            Node.Data := EN;
          End;
        ptDtdc: Begin
            Node := TreeView.Items.AddChild (Parent, 'DTD');
            Node.ImageIndex := Img_Dtd;
            EN := TElementNode.Create (StrSFPas (XmlParser.CurStart, XmlParser.CurFinal), Nil);
            Node.Data := EN;
          End;
        ptStartTag,
          ptEmptyTag: Begin
            Node := TreeView.Items.AddChild (Parent, XmlParser.CurName);
            If XmlParser.CurAttr.Count > 0 Then Begin
              Node.ImageIndex := Img_TagWithAttr;
              EN := TElementNode.Create ('', XmlParser.CurAttr);
              Elements.Add (EN);
              Node.Data := EN;
            End
            Else
              Node.ImageIndex := Img_Tag;

            If XmlParser.CurPartType = ptStartTag Then // Recursion
              ScanElement (Node);
          End;
        ptEndTag: Break;
        ptContent,
          ptCData: Begin
            EN := TElementNode.Create (XmlParser.CurContent, Nil);
            Node := TreeView.Items.AddChild (Parent, '--- ' + EN.Content);
            Node.ImageIndex := Img_Text;
            Node.Data := EN;
          End;
        ptComment: Begin
            Node := TreeView.Items.AddChild (Parent, 'Comentário');
            Node.ImageIndex := Img_Comment;
            SetStringSF (Strg, XmlParser.CurStart + 4, XmlParser.CurFinal - 3);
            EN := TElementNode.Create (TrimWs (Strg), Nil);
            Node.Data := EN;
          End;
        ptPI: Begin
            Node := TreeView.Items.AddChild (Parent, XmlParser.CurName + ' ' + XmlParser.CurContent);
            Node.ImageIndex := Img_PI;
          End;
      End;
      If Node <> Nil Then
        Node.SelectedIndex := Node.ImageIndex;
    End;
  End;

Begin
  TreeView.Items.BeginUpdate;
  TreeView.Items.Clear;
  XmlParser.Normalize := True;
  XmlParser.StartScan;
  ScanElement (Nil);
  TreeView.Items.EndUpdate;
  TreeView.FullExpand;
End;

Procedure TXMLForm.ReadFile (Const Filename: String);
Begin
  { Clear TreeView }
  Screen.Cursor := crHourGlass;
  Elements.Clear;

  { Load and Scan XML document }
  XmlParser.LoadFromFile (Filename);

  { Fill Element tree }
  CreateTree := True;
  FillTree;
  CreateTree := False;

  Screen.Cursor := crDefault;
End;

Procedure TXMLForm.FileReturnItemClick (Sender: TObject);
Begin
  Close;
End;

Procedure TXMLForm.FormCreate (Sender: TObject);
Begin
  XmlParser := TXmlParser.Create;
  Elements := TObjectList.Create;
End;

Procedure TXMLForm.FormDestroy (Sender: TObject);
Begin
  Elements.Free;
  XmlParser.Free;
End;

End.

