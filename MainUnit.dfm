object Form1: TForm1
  Left = 330
  Top = 91
  Width = 1240
  Height = 834
  Caption = #1054#1073#1098#1103#1074#1083#1077#1085#1080#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pgc1: TPageControl
    Left = 8
    Top = 8
    Width = 1217
    Height = 865
    ActivePage = ts3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object ts1: TTabSheet
      Caption = 'Learning'
      object lbl1: TLabel
        Left = 16
        Top = 8
        Width = 36
        Height = 16
        Caption = 'Sites'
      end
      object lbl2: TLabel
        Left = 304
        Top = 8
        Width = 98
        Height = 16
        Caption = 'Current page: '
      end
      object mmo1: TMemo
        Left = 16
        Top = 32
        Width = 273
        Height = 593
        Lines.Strings = (
          'http://www.ua.all.biz/board/index.php?action=form'
          'http://board.join.ua/add/'
          'http://emarket.ua/adding/'
          'http://slando.ua/post-new-ad/')
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object mmo2: TMemo
        Left = 0
        Top = 712
        Width = 1193
        Height = 113
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 1
      end
      object wb1: TWebBrowser
        Left = 296
        Top = 32
        Width = 897
        Height = 673
        TabOrder = 2
        OnDocumentComplete = wb1DocumentComplete
        ControlData = {
          4C000000B55C00008E4500000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E12620A000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object btn3: TButton
        Left = 48
        Top = 640
        Width = 177
        Height = 25
        Caption = 'Start'
        TabOrder = 3
        OnClick = btn3Click
      end
      object btn1: TButton
        Left = 48
        Top = 672
        Width = 177
        Height = 25
        Caption = 'Next >>'
        Enabled = False
        TabOrder = 4
        OnClick = btn1Click
      end
    end
    object ts2: TTabSheet
      Caption = 'Data for offer'
      ImageIndex = 1
      object lbl5: TLabel
        Left = 8
        Top = 32
        Width = 71
        Height = 16
        Caption = 'Title [title]'
      end
      object lbl6: TLabel
        Left = 8
        Top = 64
        Width = 112
        Height = 16
        Caption = 'Adress [adress]'
      end
      object lbl7: TLabel
        Left = 8
        Top = 96
        Width = 126
        Height = 16
        Caption = 'Price, UAH [price]'
      end
      object lbl8: TLabel
        Left = 8
        Top = 128
        Width = 117
        Height = 16
        Caption = 'Contact [contact]'
      end
      object lbl9: TLabel
        Left = 8
        Top = 160
        Width = 102
        Height = 16
        Caption = 'Phone [phone]'
      end
      object lbl10: TLabel
        Left = 8
        Top = 192
        Width = 92
        Height = 16
        Caption = 'Email [email]'
      end
      object lbl11: TLabel
        Left = 8
        Top = 224
        Width = 143
        Height = 16
        Caption = 'Company [company]'
      end
      object lbl12: TLabel
        Left = 8
        Top = 256
        Width = 82
        Height = 16
        Caption = 'Item url [url]'
      end
      object lbl13: TLabel
        Left = 8
        Top = 288
        Width = 38
        Height = 16
        Caption = 'Offer:'
      end
      object edt1: TEdit
        Left = 216
        Top = 32
        Width = 369
        Height = 24
        TabOrder = 0
      end
      object edt2: TEdit
        Left = 216
        Top = 64
        Width = 369
        Height = 24
        TabOrder = 1
      end
      object edt3: TEdit
        Left = 216
        Top = 96
        Width = 369
        Height = 24
        TabOrder = 2
      end
      object edt4: TEdit
        Left = 216
        Top = 128
        Width = 369
        Height = 24
        TabOrder = 3
      end
      object edt5: TEdit
        Left = 216
        Top = 160
        Width = 369
        Height = 24
        TabOrder = 4
      end
      object edt6: TEdit
        Left = 216
        Top = 192
        Width = 369
        Height = 24
        TabOrder = 5
        Text = 'nadin@nadin.cc.ua'
      end
      object edt7: TEdit
        Left = 216
        Top = 224
        Width = 369
        Height = 24
        TabOrder = 6
        Text = 'nadin.cc.ua'
      end
      object edt8: TEdit
        Left = 216
        Top = 256
        Width = 369
        Height = 24
        TabOrder = 7
        Text = 
          'http://nadin.cc.ua/%D0%BA%D0%B0%D1%82%D0%B0%D0%BB%D0%BE%D0%B3-%D' +
          '1%82%D0%BE%D0%B2%D0%B0%D1%80%D0%BE%D0%B2'
      end
      object mmo5: TMemo
        Left = 8
        Top = 312
        Width = 577
        Height = 305
        TabOrder = 8
      end
    end
    object ts3: TTabSheet
      Caption = 'Send offer'
      ImageIndex = 2
      object lbl3: TLabel
        Left = 16
        Top = 56
        Width = 36
        Height = 16
        Caption = 'Sites'
      end
      object lbl4: TLabel
        Left = 304
        Top = 8
        Width = 98
        Height = 16
        Caption = 'Current page: '
      end
      object lbl14: TLabel
        Left = 16
        Top = 8
        Width = 79
        Height = 16
        Caption = 'Begin from:'
      end
      object mmo3: TMemo
        Left = 16
        Top = 80
        Width = 273
        Height = 521
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object wb2: TWebBrowser
        Left = 296
        Top = 32
        Width = 897
        Height = 673
        TabOrder = 1
        OnDocumentComplete = wb2DocumentComplete
        ControlData = {
          4C000000B55C00008E4500000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E12620A000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object btn2: TButton
        Left = 48
        Top = 608
        Width = 177
        Height = 25
        Caption = 'Start'
        TabOrder = 2
        OnClick = btn2Click
      end
      object btn4: TButton
        Left = 48
        Top = 672
        Width = 177
        Height = 25
        Caption = 'Next >>'
        Enabled = False
        TabOrder = 3
        OnClick = btn4Click
      end
      object mmo4: TMemo
        Left = 0
        Top = 712
        Width = 1193
        Height = 113
        ReadOnly = True
        ScrollBars = ssBoth
        TabOrder = 4
      end
      object btn5: TButton
        Left = 48
        Top = 640
        Width = 177
        Height = 25
        Caption = 'Update again'
        Enabled = False
        TabOrder = 5
        OnClick = btn5Click
      end
      object edt9: TEdit
        Left = 16
        Top = 32
        Width = 265
        Height = 24
        TabOrder = 6
        Text = '0'
      end
    end
  end
  object xmldcmnt1: TXMLDocument
    Left = 612
    Top = 75
    DOMVendorDesc = 'MSXML'
  end
end
