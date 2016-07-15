unit MainFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.MongoDB, FireDAC.Phys.MongoDBDef, System.Rtti, System.JSON.Types,
  System.JSON.Readers, System.JSON.BSON, System.JSON.Builders,
  FireDAC.Phys.MongoDBWrapper, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Phys.MongoDBDataSet;

type
  TfrmMain = class(TForm)
    btnConnect: TButton;
    btnAdd: TButton;
    btnRead: TButton;
    btnUpdate: TButton;
    btnDelete: TButton;
    memLog: TMemo;
    FDMongoQuery: TFDMongoQuery;
    FDConnection: TFDConnection;
    procedure btnAddClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnReadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FConnected: Boolean;
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
  i: Integer;
  MongConn: TMongoConnection;
  MongoDoc: TMongoDocument;
  MongoEnv: TMongoEnv;
begin
  MongConn := TMongoConnection(FDConnection.CliObj);
  MongoEnv := MongConn.Env;
  MongConn[DB_NAME][COLLECTION_NAME].RemoveAll;
  for i := 1 to 10 do
  begin
    MongoDoc := MongoEnv.NewDoc;
    try
      MongoDoc
        .Add('name', 'Name ' + IntToStr(i) + ' - Record ' + IntToStr(i));
      MongConn[DB_NAME][COLLECTION_NAME].Insert(MongoDoc);
    finally
      MongoDoc.Free;
    end;
  end;
  LogMessage('Added 10 documents');
end;

procedure TfrmMain.btnConnectClick(Sender: TObject);
begin
  if FConnected = False then
  begin
    FDMongoQuery.DatabaseName := DB_NAME;
    FDMongoQuery.CollectionName := COLLECTION_NAME;
    FDMongoQuery.Open;
    btnConnect.Caption := 'Disconnect';
    FConnected := True;
  end
  else
  begin
    FDMongoQuery.Close;
    FDMongoQuery.FieldDefs.Clear;
    btnConnect.Caption := 'Connect';
    FConnected := False;
  end;
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
begin
  FDMongoQuery.First;
  while not FDMongoQuery.Eof do
    FDMongoQuery.Delete;
  LogMessage('All documents was deleted');
end;

procedure TfrmMain.btnReadClick(Sender: TObject);
begin
  FDMongoQuery.Close;
  FDMongoQuery.Open;
  FDMongoQuery.First;
  while not FDMongoQuery.Eof do
  begin
    LogMessage('Record: ' + FDMongoQuery.FieldByName('name').AsString);
    FDMongoQuery.Next;
  end;
  if FDMongoQuery.IsEmpty then
    LogMessage('No records found');
end;

procedure TfrmMain.btnUpdateClick(Sender: TObject);
var
  i: Integer;
begin
  FDMongoQuery.Close;
  FDMongoQuery.Open;
  FDMongoQuery.First;
  i := 1;
  while not FDMongoQuery.Eof do
  begin
    FDMongoQuery.Edit;
    FDMongoQuery.FieldByName('name').AsString := 'Updated ' + IntToStr(i);
    FDMongoQuery.Post;
    Inc(i);
    FDMongoQuery.Next;
  end;
  LogMessage('All documents updated');
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FDMongoQuery.Close;
end;

procedure TfrmMain.LogMessage(const AMessage: string);
begin
  memLog.Lines.Append(AMessage);
end;

end.
