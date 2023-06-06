unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MemTableDataEh, Data.DB, MemTableEh, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.StdCtrls, System.StrUtils, FIBQuery,
  pFIBQuery, FIBDatabase, pFIBDatabase, System.Actions, Vcl.ActnList;

type
  TForm1 = class(TForm)
    mds: TMemTableEh;
    grEh: TDBGridEh;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Button3: TButton;
    DBase: TpFIBDatabase;
    tmpTrans: TpFIBTransaction;
    tmpQry: TpFIBQuery;
    mds_full: TMemTableEh;
    ActList: TActionList;
    ActFillMDS_Full: TAction;
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure mdsRecordsViewTreeNodeExpanding(Sender: TObject; Node: TMemRecViewEh; var AllowExpansion: Boolean);
    procedure mdsRecordsViewTreeNodeExpanded(Sender: TObject; Node: TMemRecViewEh);
    procedure grEhSelectionChanged(Sender: TObject);
    procedure grEhCellClick(Column: TColumnEh);
    procedure ActFillMDS_FullExecute(Sender: TObject);
  private
    { Private declarations }
    procedure EdtChgEvent(Sender: TObject);
  public
    { Public declarations }
  end;

const
  DataFile = 'c:\proj\test_delphi\delphi_mkb10\base\mkb10_import.txt';

  SQLSelectWhere =
        'SELECT ' +
          'CAST(SUBSTRING(MKB_VALUES ' +
                          'FROM 1 ' +
                          'FOR (POSITION('' '',MKB_VALUES)-1)) AS VARCHAR(10)) ' +
            'AS MKB_CODE' +
          ', CAST(SUBSTRING(MKB_VALUES ' +
                          'FROM (POSITION('' '',MKB_VALUES)+1) ' +
                          'FOR (CHAR_LENGTH(MKB_VALUES)-POSITION('' '',MKB_VALUES)+1)) AS VARCHAR(260)) ' +
            'AS MKB_CAPTION' +
          ', TREE_ID' +
          ', VALUES_UID ' +
        'FROM TBL_MKB10 ' +
        'WHERE (TREE_ID = :TREE_ID)';

  SQLSelectFull =
        'SELECT ' +
          'CAST(SUBSTRING(MKB_VALUES ' +
                          'FROM 1 ' +
                          'FOR (POSITION('' '',MKB_VALUES)-1)) AS VARCHAR(10)) ' +
            'AS MKB_CODE' +
          ', CAST(SUBSTRING(MKB_VALUES ' +
                          'FROM (POSITION('' '',MKB_VALUES)+1) ' +
                          'FOR (CHAR_LENGTH(MKB_VALUES)-POSITION('' '',MKB_VALUES)+1)) AS VARCHAR(260)) ' +
            'AS MKB_CAPTION' +
          ', TREE_ID' +
          ', VALUES_UID ' +
        'FROM TBL_MKB10 ' +
        'ORDER BY VALUES_UID';

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ActFillMDS_FullExecute(Sender: TObject);
const
  a = '(''';
  b = ' ';
  c = ''', ';
  d = ', ';
  e = ');';
var
  SL: TStringList;
  i: Integer;
  s, ss: string;
  k,m,n: Integer;
begin
  SL:= TStringList.Create;

  try
    SL.LoadFromFile(DataFile, TEncoding.UTF8);
    mds_full.DisableControls;
    if mds_full.Active
      then mds_full.EmptyTable
      else mds_full.Active:= True;

    for i := 0 to Pred(SL.Count) do
    begin
      mds_full.Append;
//      s:= SL.Strings[i];
//      k:= PosEx(a,s) + System.Length(a);
//      m:= PosEx(b,s,k);
//      ss:= '~' + Copy(s,k,m-k) + '~';

//      k:= m + System.Length(b);
//      m:= PosEx(c,s,k);
//      ss:= '~' + Copy(s,k,m-k) + '~';

//      k:= m + System.Length(c);
//      m:= PosEx(d,s,k);
//      ss:= '~' + Copy(s,k,m-k) + '~';
//
//      k:= m + System.Length(d);
//      m:= PosEx(e,s,k);
//      ss:= '~' + Copy(s,k,m-k) + '~';

      k:= PosEx(a,SL.Strings[i]) + System.Length(a);
      m:= PosEx(b,SL.Strings[i],k);
      mds_full.FieldByName('MKB_CODE').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(b);
      m:= PosEx(c,SL.Strings[i],k);
      mds_full.FieldByName('MKB_CAPTION').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(c);
      m:= PosEx(d,SL.Strings[i],k);
      mds_full.FieldByName('TREE_ID').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(d);
      m:= PosEx(e,SL.Strings[i],k);
      mds_full.FieldByName('VALUES_UID').AsString:= Copy(SL.Strings[i],k,m-k);
    end;
    mds_full.Post;
  finally
    FreeAndNil(SL);
    mds_full.EnableControls;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
//Exit;
  mds.DisableControls;
  try
    if CheckBox1.Checked
    then
      begin
        grEh.Options:= grEh.Options - [dgIndicator];
      end
    else
      begin
        grEh.Options:= grEh.Options + [dgIndicator];
      end;

    mds.TreeList.Active:= CheckBox1.Checked;
  finally
    mds.EnableControls;
  end;
end;

procedure TForm1.EdtChgEvent(Sender: TObject);
begin
//  mds.DisableControls;
//  mds.Locate('MKB_VALUES', Trim(Edit1.Text),[loCaseInsensitive, loPartialKey]);
//  mds.EnableControls;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  //заставляем скроллироваться через грид записи в мемтабле
  DBGridEhCenter.UseExtendedScrollingForMemTable:= False;

  with mds do
  begin
    FieldDefs.Add('MKB_CODE', ftString, 10);
    FieldDefs.Add('MKB_CAPTION', ftString, 260);
    FieldDefs.Add('TREE_ID', ftInteger);
    FieldDefs.Add('VALUES_UID', ftInteger);

    CreateDataSet;
    Filtered := False;
    Active := False;
  end;

  with mds_full do
  begin
    FieldDefs.Add('MKB_CODE', ftString, 10);
    FieldDefs.Add('MKB_CAPTION', ftString, 260);
    FieldDefs.Add('TREE_ID', ftInteger);
    FieldDefs.Add('VALUES_UID', ftInteger);

    CreateDataSet;
    Filtered := False;
    Active := False;
  end;

  ActFillMDS_FullExecute(Sender);
  mds_full.TreeList.KeyFieldName:= 'VALUES_UID';
  mds_full.TreeList.RefParentFieldName:= 'TREE_ID';
  mds_full.TreeList.Active:= True;
//  Exit;
//
//  mds.Active:= True;
//  mds.DisableControls;
//  DBase.Connected:= True;
//
//  try
//    tmpTrans.StartTransaction;
//    tmpQry.Close;
//    tmpQry.SQL.Text:= SQLSelectWhere;
//
//    tmpQry.Prepare;
//    tmpQry.ParamByName('TREE_ID').Value:= 0;
//    tmpQry.ExecQuery;
//
//    while not tmpQry.Eof do
//    begin
//      mds.AppendRecord([
//          tmpQry.FieldByName('MKB_CODE').AsString,
//          tmpQry.FieldByName('MKB_CAPTION').AsString,
//          tmpQry.FieldByName('TREE_ID').AsInteger,
//          tmpQry.FieldByName('VALUES_UID').AsInteger
//                      ]);
//      tmpQry.Next;
//    end;
//
//    tmpQry.Close;
//    tmpQry.SQL.Text:= SQLSelectFull;
//
//    tmpQry.ExecQuery;
//
//    mds_full.Active:= True;
//    while not tmpQry.Eof do
//    begin
//      mds_full.AppendRecord([
//          tmpQry.FieldByName('MKB_CODE').AsString,
//          tmpQry.FieldByName('MKB_CAPTION').AsString,
//          tmpQry.FieldByName('TREE_ID').AsInteger,
//          tmpQry.FieldByName('VALUES_UID').AsInteger
//                      ]);
//      tmpQry.Next;
//    end;
//
//    tmpTrans.Commit;
//  except
//    on E: Exception do
//    begin
//      tmpTrans.Rollback;
//      ShowMessage(e.Message);
//    end;
//  end;
//  mds.EnableControls;
//
//  CheckBox1Click(Sender);
end;

procedure TForm1.grEhCellClick(Column: TColumnEh);
begin
//  Self.Caption:= TMemTableEh(grEh.DataSource.DataSet).TreeNode.Rec.DataValues['MKB_VALUES',dvvValueEh];
end;

procedure TForm1.grEhSelectionChanged(Sender: TObject);
begin
//  Self.Caption:= TMemTableEh(grEh.DataSource.DataSet).TreeNode.Rec.DataValues['VALUES_UID',dvvValueEh];
end;

procedure TForm1.mdsRecordsViewTreeNodeExpanded(Sender: TObject; Node: TMemRecViewEh);
begin
//  Node.NodeHasChildren:= (Node.NodesCount > 0);
end;

procedure TForm1.mdsRecordsViewTreeNodeExpanding(Sender: TObject; Node: TMemRecViewEh; var AllowExpansion: Boolean);
var
  tmpID, i: Integer;
begin
//  Self.Caption:= Node.Rec.DataValues['MKB_VALUES',dvvValueEh];
  try
//    for i := 0 to Pred(grEh.SelectedRows.Count) do
//    grEh.SelectedRows.CurrentRowSelected:= False;

    mds.TreeList.Locate('VALUES_UID',Node.Rec.DataValues['VALUES_UID',dvvValueEh],[]);
//    grEh.SelectedRows.CurrentRowSelected:= True;

    mds.DisableControls;
    if (mds.TreeNodeChildCount = 0) then
    begin
      tmpID:= Node.Rec.DataValues['VALUES_UID',dvvValueEh];
      try
        tmpTrans.StartTransaction;
        tmpQry.Close;
        tmpQry.SQL.Text:= SQLSelectWhere;

        tmpQry.Prepare;
        tmpQry.ParamByName('TREE_ID').Value:= tmpID;
        tmpQry.ExecQuery;

        while not tmpQry.Eof do
        begin
          mds.AppendRecord([
          tmpQry.FieldByName('MKB_CODE').AsString,
          tmpQry.FieldByName('MKB_CAPTION').AsString,
          tmpQry.FieldByName('TREE_ID').AsInteger,
          tmpQry.FieldByName('VALUES_UID').AsInteger
                          ]);
          tmpQry.Next;
        end;

        tmpTrans.Commit;

      except
        on E: Exception do
        begin
          tmpTrans.Rollback;
          ShowMessage(e.Message);
        end;
      end;
    end;
  finally
    mds.EnableControls;
//    Self.Caption:= 'ChildNode Count: ' + IntToStr(Node.NodesCount);
//    Node.NodeHasChildren:= (Node.NodesCount > 0);

  end;
end;

end.
