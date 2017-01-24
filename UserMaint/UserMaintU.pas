Unit UserMaintU;

Interface
Uses sysutils, forms, inifiles, classes, dialogs, Windows, System.UITypes;
  Type TActiveWindow = Class(Tobject)
  Private
    //
  Public
    //
  End;

  Function  AddProgName(TheName : String):Integer;
  Procedure DelProgName;
  Procedure OpenTables;
  Function  AddUser(FormTop, FormLeft : Integer):Boolean;
  Procedure DelUser;

Implementation

Uses globals, dmoUserMaintU, frmAddUserU;


Procedure OpenTables;
Begin
//  Beware Global Variables
  iProgNameID := dmoUserMaint.OpenQueryPrograme;  //  Also opens menuItems Grid for selected Prog
  LogInUserID := dmoUserMaint.OpenQueryUser;
  UserRoleID  := dmoUserMaint.GetUserRoleID(LogInUserID);
  dmoUserMaint.OpenQueryUserRole;   // gets 3 Global variables
                                    // UserRoleID, UserAccessLevel, UserAccessName
  dmoUserMaint.OpenQueryMenuItems;
End;


Function  AddProgName(TheName : String):Integer;
Begin
  If TheName > 'A' then
  Begin
    Result := dmoUserMaint.AddNewProg(TheName);
    dmoUserMaint.OpenQueryPrograme;      //  Reopen query because used in dmoUserMaint.AddNewProg
  End
  Else
  Begin
    Error('Programme name must start with a letter');
    Result := 0;
  End;
End;



Procedure DelProgName;
Begin
  If Question('Are you ABSOLUTELY sure') Then
    dmoUserMaint.DeleteProg;
End;


Function  AddUser(FormTop, FormLeft : Integer):Boolean;
Var
  iAdded : Integer;
Begin
  FormTop  := FormTop + 120;
  FormLeft := FormLeft + 120;
  frmAddUser.Top := FormTop;
  frmAddUser.Left := FormLeft;
  iAdded := frmAddUser.ShowModal;
  if iAdded = mrOK then
  Begin
    GbUserNew := True;
  End
  Else
  Begin
    GbUserNew := False;
  End;
  Result := GbUserNew;
End;


Procedure DelUser;
Begin
  If Question('Are you ABSOLUTELY sure') Then
    dmoUserMaint.DeleteUser;
End;


End.


