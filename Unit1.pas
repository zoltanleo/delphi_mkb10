unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MemTableDataEh, Data.DB, MemTableEh, DBGridEhGrouping, ToolCtrlsEh,
  DBGridEhToolCtrls, DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh, Vcl.StdCtrls, System.StrUtils, FIBQuery,
  pFIBQuery, FIBDatabase, pFIBDatabase, System.Actions, Vcl.ActnList, EhLibMTE;

type
  TForm1 = class(TForm)
    mds_d: TMemTableEh;
    grEh: TDBGridEh;
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    Button3: TButton;
    mds_m: TMemTableEh;
    ActList: TActionList;
    ActFillMDS_Full: TAction;
    ds_m: TDataSource;
    mds_src: TMemTableEh;
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure ActFillMDS_FullExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mds_mRecordsViewTreeNodeExpanding(Sender: TObject; Node: TMemRecViewEh; var AllowExpansion: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure mds_mAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  DataFile = 'c:\proj\test_delphi\delphi_mkb10\base\mkb10.sql';
  ExcludeStr1 = 'INSERT INTO';
  ExcludeStr2 = 'REINSERT (';

{$REGION 'skiped code'}
  //  SQLSelectWhere =
  //        'SELECT ' +
  //          'CAST(SUBSTRING(MKB_VALUES ' +
  //                          'FROM 1 ' +
  //                          'FOR (POSITION('' '',MKB_VALUES)-1)) AS VARCHAR(10)) ' +
  //            'AS MKB_CODE' +
  //          ', CAST(SUBSTRING(MKB_VALUES ' +
  //                          'FROM (POSITION('' '',MKB_VALUES)+1) ' +
  //                          'FOR (CHAR_LENGTH(MKB_VALUES)-POSITION('' '',MKB_VALUES)+1)) AS VARCHAR(260)) ' +
  //            'AS MKB_CAPTION' +
  //          ', TREE_ID' +
  //          ', VALUES_UID ' +
  //        'FROM TBL_MKB10 ' +
  //        'WHERE (TREE_ID = :TREE_ID)';
  //
  //  SQLSelectFull =
  //        'SELECT ' +
  //          'CAST(SUBSTRING(MKB_VALUES ' +
  //                          'FROM 1 ' +
  //                          'FOR (POSITION('' '',MKB_VALUES)-1)) AS VARCHAR(10)) ' +
  //            'AS MKB_CODE' +
  //          ', CAST(SUBSTRING(MKB_VALUES ' +
  //                          'FROM (POSITION('' '',MKB_VALUES)+1) ' +
  //                          'FOR (CHAR_LENGTH(MKB_VALUES)-POSITION('' '',MKB_VALUES)+1)) AS VARCHAR(260)) ' +
  //            'AS MKB_CAPTION' +
  //          ', TREE_ID' +
  //          ', VALUES_UID ' +
  //        'FROM TBL_MKB10 ' +
  //        'ORDER BY VALUES_UID';
{$ENDREGION}

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
  if mds_src.Active
    then mds_src.EmptyTable
    else mds_src.Active:= True;

  SL:= TStringList.Create;

  try
    SL.LoadFromFile(DataFile, TEncoding.UTF8);
    for i := 0 to Pred(SL.Count) do
    begin
      if (Pos(ExcludeStr1,SL.Strings[i]) = 0) then
        if (Pos(ExcludeStr2,SL.Strings[i]) = 0) then Continue;

      mds_src.Append;

      k:= PosEx(a,SL.Strings[i]) + System.Length(a);
      m:= PosEx(b,SL.Strings[i],k);
      mds_src.FieldByName('MKB_CODE').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(b);
      m:= PosEx(c,SL.Strings[i],k);
      mds_src.FieldByName('MKB_CAPTION').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(c);
      m:= PosEx(d,SL.Strings[i],k);
      mds_src.FieldByName('TREE_ID').AsString:= Copy(SL.Strings[i],k,m-k);

      k:= m + System.Length(d);
      m:= PosEx(e,SL.Strings[i],k);
      mds_src.FieldByName('VALUES_UID').AsString:= Copy(SL.Strings[i],k,m-k);
    end;

    if not (mds_src.State in [dsBrowse]) then mds_src.Post;

  finally
    FreeAndNil(SL);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Self.Caption:= Format('current values: %s[%s]',[
                         mds_m.TreeNode.Rec.DataValues['MKB_CAPTION',dvvValueEh],
                         mds_m.TreeNode.Rec.DataValues['MKB_CODE',dvvValueEh]
                                                ]);
  if grEh.CanFocus then grEh.SetFocus;
  
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  mds_m.DisableControls;
  try
    if CheckBox1.Checked
      then grEh.Options:= grEh.Options - [dgIndicator]
      else grEh.Options:= grEh.Options + [dgIndicator];

    mds_m.TreeList.Active:= CheckBox1.Checked;
  finally
    mds_m.EnableControls;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  //заставляем скроллироваться через грид записи в мемтабле
  DBGridEhCenter.UseExtendedScrollingForMemTable:= False;

  with mds_src do
  begin
    FieldDefs.Add('MKB_CODE', ftString, 10);
    FieldDefs.Add('MKB_CAPTION', ftString, 260);
    FieldDefs.Add('TREE_ID', ftInteger);
    FieldDefs.Add('VALUES_UID', ftInteger);

    CreateDataSet;
    Filtered := False;
    Active := False;
  end;

  with mds_m do
  begin
    FieldDefs.Add('MKB_CODE', ftString, 10);
    FieldDefs.Add('MKB_CAPTION', ftString, 260);
    FieldDefs.Add('TREE_ID', ftInteger);
    FieldDefs.Add('VALUES_UID', ftInteger);

    CreateDataSet;
    Filtered := False;
    Active := False;
    TreeList.DefaultNodeHasChildren:= True;
  end;

  with mds_d do
  begin
    FieldDefs.Add('MKB_CODE', ftString, 10);
    FieldDefs.Add('MKB_CAPTION', ftString, 260);
    FieldDefs.Add('TREE_ID', ftInteger);
    FieldDefs.Add('VALUES_UID', ftInteger);

    CreateDataSet;
    Filtered := False;
    Active := False;
  end;

  mds_m.TreeList.KeyFieldName:= 'VALUES_UID';
  mds_m.TreeList.RefParentFieldName:= 'TREE_ID';
  mds_m.TreeList.Active:= True;

  mds_d.ExternalMemData:= mds_src;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  try
    mds_m.DisableControls;
    CheckBox1Click(Sender);
    ActFillMDS_FullExecute(Sender);

    mds_m.Active:= True;
    mds_d.Active:= True;

    mds_d.Filtered:= False;
    mds_d.Filter:= 'TREE_ID=0';
    mds_d.Filtered:= True;

    if not mds_d.IsEmpty then
    begin
      mds_d.First;

      while not mds_d.Eof do
      begin
        mds_m.AppendRecord([
            mds_d.Fields[0].Value,
            mds_d.Fields[1].Value,
            mds_d.Fields[2].Value,
            mds_d.Fields[3].Value
                            ]);
        mds_d.Next;
      end;

      mds_m.First;
    end;
  finally
    mds_m.EnableControls;
  end;
end;

procedure TForm1.mds_mAfterScroll(DataSet: TDataSet);
begin
  if not mds_m.Active then Exit;

    Self.Caption:= Format('current values: %s[%s]',[
                         mds_m.TreeNode.Rec.DataValues['MKB_CAPTION',dvvValueEh],
                         mds_m.TreeNode.Rec.DataValues['MKB_CODE',dvvValueEh]
                                                ]);
end;

procedure TForm1.mds_mRecordsViewTreeNodeExpanding(Sender: TObject; Node: TMemRecViewEh; var AllowExpansion: Boolean);
var
  tmpID: Integer;
begin
  try
    Self.Caption:= Format('current values: %s[%s]',[
                         Node.Rec.DataValues['MKB_CAPTION',dvvValueEh],
                         Node.Rec.DataValues['MKB_CODE',dvvValueEh]
                                                ]);
    mds_m.TreeList.Locate('VALUES_UID',Node.Rec.DataValues['VALUES_UID',dvvValueEh],[]);

    tmpID:= System.Integer(Node.Rec.DataValues['VALUES_UID',dvvValueEh]);

    mds_m.DisableControls;
    if (mds_m.TreeNodeChildCount = 0) then
    begin
      mds_d.Filtered:= False;
      mds_d.Filter:= Format('TREE_ID=%d',[System.Integer(Node.Rec.DataValues['VALUES_UID',dvvValueEh])]);
      mds_d.Filtered:= True;

      if mds_d.IsEmpty then
      begin
        Node.NodeHasVisibleChildren:= False;
        Exit;
      end;

      mds_d.First;
      while not mds_d.Eof do
      begin
        mds_m.AppendRecord([
            mds_d.Fields[0].Value,
            mds_d.Fields[1].Value,
            mds_d.Fields[2].Value,
            mds_d.Fields[3].Value
                            ]);
        mds_d.Next;
      end;
    end;
  finally
    mds_m.EnableControls;
  end;
end;

end.
