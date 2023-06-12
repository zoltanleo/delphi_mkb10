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
  OnCreate = FormCreate
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
    ColumnDefValues.EndEllipsis = True
    ColumnDefValues.Title.ToolTips = True
    ColumnDefValues.ToolTips = True
    DataSource = ds_m
    DynProps = <>
    GridLineParams.VertEmptySpaceStyle = dessNonEh
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghRowHighlight, dghColumnResize, dghColumnMove]
    ParentShowHint = False
    ReadOnly = True
    SearchPanel.WholeWords = True
    ShowHint = True
    SortLocal = True
    TabOrder = 0
    TreeViewParams.ShowTreeLines = False
    Columns = <
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MKB_CODE'
        Footers = <>
        Title.EndEllipsis = True
        Title.TitleButton = True
        Width = 150
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'MKB_CAPTION'
        Footers = <>
        Title.EndEllipsis = True
        Title.TitleButton = True
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'VALUES_UID'
        Footers = <>
        Title.EndEllipsis = True
        Title.TitleButton = True
      end
      item
        CellButtons = <>
        DynProps = <>
        EditButtons = <>
        FieldName = 'TREE_ID'
        Footers = <>
        Title.EndEllipsis = True
        Title.TitleButton = True
      end>
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
    ExplicitLeft = 752
    ExplicitTop = 340
  end
  object Button2: TButton
    Left = 675
    Top = 341
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Button2'
    TabOrder = 2
    OnClick = Button2Click
    ExplicitLeft = 671
    ExplicitTop = 340
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
    ExplicitTop = 348
  end
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 742
    Height = 23
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
    Text = 'Edit1'
    ExplicitWidth = 738
  end
  object Button3: TButton
    Left = 756
    Top = 8
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = 'Button3'
    TabOrder = 5
    ExplicitLeft = 752
  end
  object mds_d: TMemTableEh
    ExternalMemData = mds_m
    Params = <>
    TreeList.KeyFieldName = 'VALUES_UID'
    TreeList.RefParentFieldName = 'TREE_ID'
    TreeList.DefaultNodeHasChildren = True
    TreeList.FullBuildCheck = False
    TreeList.FilterNodeIfParentVisible = False
    Left = 136
    Top = 88
  end
  object mds_m: TMemTableEh
    Params = <>
    TreeList.FullBuildCheck = False
    TreeList.FilterNodeIfParentVisible = False
    AfterScroll = mds_mAfterScroll
    OnRecordsViewTreeNodeExpanding = mds_mRecordsViewTreeNodeExpanding
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
  object ds_m: TDataSource
    AutoEdit = False
    DataSet = mds_m
    Left = 240
    Top = 104
  end
  object mds_src: TMemTableEh
    Params = <>
    Left = 384
    Top = 112
  end
end
