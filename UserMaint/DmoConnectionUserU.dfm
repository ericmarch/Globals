object dmoConnectionUser: TdmoConnectionUser
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 264
  Width = 377
  object conUserMaint: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=1ntelPWD!;Persist Security Info=Tru' +
      'e;User ID=sa;Initial Catalog=UserMaint;Data Source=HARRIER\HARRI' +
      'ER2008R2'
    LoginPrompt = False
    Mode = cmShareExclusive
    Provider = 'SQLOLEDB.1'
    BeforeConnect = conUserMaintBeforeConnect
    Left = 40
    Top = 40
  end
end
