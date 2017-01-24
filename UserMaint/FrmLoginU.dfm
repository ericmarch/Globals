object dlgLogin: TdlgLogin
  Left = 270
  Top = 100
  Caption = 'Login'
  ClientHeight = 200
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object edtUserName: TEdit
    Left = 80
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 0
    OnChange = edtUserNameChange
  end
  object edtPassword: TEdit
    Left = 80
    Top = 92
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    OnChange = edtPasswordChange
    OnEnter = edtPasswordEnter
  end
  object Panel1: TPanel
    Left = 0
    Top = 159
    Width = 288
    Height = 41
    Align = alBottom
    TabOrder = 2
    object btnOK: TBitBtn
      Left = 24
      Top = 8
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 152
      Top = 8
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnCancelClick
    end
  end
  object txtUser: TStaticText
    Left = 48
    Top = 48
    Width = 26
    Height = 17
    Caption = 'User'
    TabOrder = 3
  end
  object txtPassword: TStaticText
    Left = 24
    Top = 96
    Width = 50
    Height = 17
    Caption = 'Password'
    TabOrder = 4
  end
end
