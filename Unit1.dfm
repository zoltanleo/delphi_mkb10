object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 374
  ClientWidth = 843
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  DesignSize = (
    843
    374)
  TextHeight = 15
  object grEh: TDBGridEh
    Left = 8
    Top = 39
    Width = 823
    Height = 296
    Anchors = [akLeft, akTop, akRight, akBottom]
    AutoFitColWidths = True
    DataSource = DataSource1
    DynProps = <>
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghRowHighlight, dghColumnResize, dghColumnMove]
    ParentShowHint = False
    ReadOnly = True
    SearchPanel.WholeWords = True
    ShowHint = True
    SortLocal = True
    TabOrder = 0
    TreeViewParams.GlyphStyle = tvgsExplorerThemedEh
    TreeViewParams.ShowTreeLines = False
    OnCellClick = grEhCellClick
    OnSelectionChanged = grEhSelectionChanged
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object Button1: TButton
    Left = 756
    Top = 341
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Button1'
    TabOrder = 1
  end
  object Button2: TButton
    Left = 675
    Top = 341
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Button2'
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 349
    Width = 97
    Height = 17
    Anchors = [akLeft, akBottom]
    Caption = 'Tree View'
    Checked = True
    State = cbChecked
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 742
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    Text = 'Edit1'
  end
  object Button3: TButton
    Left = 756
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Button3'
    TabOrder = 5
  end
  object mds: TMemTableEh
    Params = <>
    TreeList.KeyFieldName = 'VALUES_UID'
    TreeList.RefParentFieldName = 'TREE_ID'
    TreeList.DefaultNodeHasChildren = True
    TreeList.FullBuildCheck = False
    TreeList.FilterNodeIfParentVisible = False
    OnRecordsViewTreeNodeExpanding = mdsRecordsViewTreeNodeExpanding
    OnRecordsViewTreeNodeExpanded = mdsRecordsViewTreeNodeExpanded
    Left = 136
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = mds_full
    Left = 248
    Top = 96
  end
  object DBase: TpFIBDatabase
    DBName = '127.0.0.1/31064:C:\proj\base\GENERAL_BASE.FDB'
    DBParams.Strings = (
      'user_name=SYSDBA'
      'password=cooladmin'
      'lc_ctype=WIN1251')
    SQLDialect = 3
    Timeout = 0
    LibraryName = 'C:\firebird\fb_3_0_10_x32\fbclient.dll'
    WaitForRestoreConnect = 0
    Left = 392
    Top = 96
  end
  object tmpTrans: TpFIBTransaction
    DefaultDatabase = DBase
    TRParams.Strings = (
      'read'
      'nowait'
      'rec_version'
      'read_committed')
    TPBMode = tpbDefault
    Left = 496
    Top = 96
  end
  object tmpQry: TpFIBQuery
    Transaction = tmpTrans
    Database = DBase
    Left = 616
    Top = 96
  end
  object mds_full: TMemTableEh
    Params = <>
    Left = 136
    Top = 184
  end
  object ActList: TActionList
    Left = 256
    Top = 176
    object ActFillMDS_Full: TAction
      Caption = 'ActFillMDS_Full'
      OnExecute = ActFillMDS_FullExecute
    end
  end
end
