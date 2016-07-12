unit MainFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, SynMongoDB, SynCommons,
  JvExStdCtrls, JvMemo;

type
  TfrmMain = class(TForm)
    btnConnect: TButton;
    btnAdd: TButton;
    memLog: TJvMemo;
    btnRead: TButton;
    btnUpdate: TButton;
    btnDelete: TButton;
    procedure btnAddClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    FConnected: Boolean;
    FDataBase: TMongoDatabase;
    procedure LogMessage(const AMessage: string);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

const
  DB_NAME = 'delphidemo';
  COLLECTION_NAME = 'anagrafica';

procedure TfrmMain.btnAddClick(Sender: TObject);
var
  Coll: TMongoCollection;
  Doc: Variant;
  i: Integer;
begin
  Coll := FDataBase.CollectionOrCreate[COLLECTION_NAME];
  TDocVariant.New(Doc);
  for i := 1 to 10 do
  begin
    Doc.Clear;
    Doc.Name := 'Name ' + IntToStr(i + 1);
    Doc.Number := i;
    Coll.Save(Doc);
  end;
  LogMessage('Added 10 documents');
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
var
  Client: TMongoClient;
  ServerTime: TDateTime;
  Res: Variant;
  errmsg: string;
begin
  if FConnected = False then
  begin
    Client := TMongoClient.Create('localhost', 27017);
    btnConnect.Caption := 'Disconnect';
    FDataBase := Client.Database[DB_NAME];
    FConnected := True;
  end
  else
  begin
    Client.Free;
    FConnected := False;
  end;
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
var
  Docs: TVariantDynArray;
  Coll: TMongoCollection;
  Json: string;
begin
  Coll := FDataBase.CollectionOrCreate[COLLECTION_NAME];
  Coll.Remove(Null);
  LogMessage('All documents was deleted');
end;

procedure TfrmMain.btnReadClick(Sender: TObject);
var
  Docs: TVariantDynArray;
  Coll: TMongoCollection;
  Json: string;
begin
  Coll := FDataBase.CollectionOrCreate[COLLECTION_NAME];
  Json := Coll.FindJSON(Null, Null);
  LogMessage(Json);
end;

procedure TfrmMain.btnUpdateClick(Sender: TObject);
var
  Coll: TMongoCollection;
  Docs: TVariantDynArray;
  i: Integer;
begin
  Coll := FDataBase.CollectionOrCreate[COLLECTION_NAME];
  Coll.FindDocs(Docs, Null);
  for i := 0 to High(Docs) do
  begin
    Docs[i].Name := 'New!';
    Coll.Update(BSONVariant(['"Name"', '"Name 2"']), Docs[i]);
  end;
  LogMessage('Documents updated');
end;

procedure TfrmMain.LogMessage(const AMessage: string);
begin
  memLog.Lines.Append(AMessage);
end;

end.
