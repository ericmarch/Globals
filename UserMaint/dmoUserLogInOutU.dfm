object dmoUserLogInOut: TdmoUserLogInOut
  OldCreateOrder = False
  Height = 311
  Width = 432
  object qrySysUser: TADOQuery
    Connection = dmoConnectionUser.conUserMaint
    Parameters = <>
    Left = 56
    Top = 120
  end
  object qryUserLog: TADOQuery
    Connection = dmoConnectionUser.conUserMaint
    Parameters = <>
    Left = 144
    Top = 120
  end
  object qryProgName: TADOQuery
    Connection = dmoConnectionUser.conUserMaint
    Parameters = <>
    Left = 224
    Top = 120
  end
  object qryUserRole: TADOQuery
    Connection = dmoConnectionUser.conUserMaint
    Parameters = <>
    Left = 320
    Top = 122
  end
end
