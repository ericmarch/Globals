unit Globals;

interface
uses sysutils,
     forms,
     strUtils,
     inifiles,
     classes,
     dialogs,
     Windows,
     System.UITypes;

  Type TActiveWindow = Class(Tobject)
  Private
    //
  Public
    //
  End;

  procedure PostKeyEx32(key: Word; const shift: TShiftState; specialkey: Boolean) ;
  Function  IntToStrPad(TheInteger, OutputLength:Integer; PadCharacter:String):string;
  Function  ReplaceCharinStr(sTheStr, sToReplace, sReplacewith : String): String;
  Function  CalculateAge(Birthday : TDateTime):Integer;
  Function  Split(Input:String;sChar:Char; s:Integer):String;
  Function  ThousSeps(dd: Double): String;
  Function  MyStripOut(s1: String):String;
 //-------------------------------------

 //MessageDlg Wrappers//
  Function  Question(theQuestion:String):Boolean;
  Procedure Error (TheError:string); //wrapper for mtError MessageDlg
  Procedure Information(TheInfo:string); //wrapper for mtInformation MessageDlg
 //-------------------------------------


var
 {Log In Variables}
  LoggedIn:boolean;
  LogInUserID:integer;
  LogInName:String;
  UserLogID : Integer;
  UserIsCurrent:boolean;
  UserRoleID:Integer;
  UserAccessLevel:Integer;
  UserAccessName:String;
  LogInDisplayName:String;
  UserEmailAddress:string;
  UserExpDirectory:string;
  UserExpFormat:string;
  LoginTherapistID:variant;
  vUserOwnerBarcodeAlert:variant;
  vLoginStatsLocation:variant;
  vLoginStatsTeam:variant;
  vLoginStatsStaff:variant;
  iProgNameID : Integer;      //  Eric 201511
  giPCodeID : Integer;        //  Eric 201611
  GbUserNew : Boolean;
  sProgDescription : String;  //  Global Variables for Contacts Login
  GbNewWreck : Boolean;       //  Global Variables for CarParts
 {defaults and settings from control file}
  EnterAsTab:boolean;
  F1Help:Boolean;
  DefEventType:integer;
  {General Variables}
  CanModReports:boolean;
  {Defaults/Settings from System Control Record}
  SystemCaption:string;
  SaveSQL: String;

 AppDir:string;
 IsCDVersion:boolean;
 CurrentVersion:integer;
 UsingSQL:boolean;
 UsingMSDE:boolean;
 IsTestSystem:boolean;
 ActiveWindow : TActiveWindow;
 gfPartID : Integer;
 gfdmItem : String;
 gfWinLeft, gfWinTop : Integer;

const
   DefaultState = 'SA';
   giCustCode = 0;
   giSuppCode = 1;
   giEmpCode  = 2;
   giPsnlCode = 3;

   DBLQuote = '"';
   TheAlphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
   CRLF = #13#10;
   aTab = #09;
   CopyRight = ' © Copyright Adelaide Business Systems 2015';
   StateList = '"ACT","NSW","NT","QLD","SA","TAS","VIC","WA"';

   //Notable Dates Constants
   ndAssociatedOrganisation = 4;
   ndClient = 3;
   ndEmployee = 9;
   ndEvent = 6;
   ndHealthProfessional = 10;
   ndProject = 2;
   ndReferral = 5;
   ndSupplier = 7;
   ndTherapist = 8;
   ndUnit = 1;


implementation


procedure PostKeyEx32(key: Word; const shift: TShiftState; specialkey: Boolean) ;
{
Parameters :
* key : virtual keycode of the key to send. For printable keys this is simply the ANSI code (Ord(character)) .
* shift : state of the modifier keys. This is a set, so you can set several of these keys (shift, control, alt, mouse buttons) in tandem. The TShiftState type is declared in the Classes Unit.
* specialkey: normally this should be False. Set it to True to specify a key on the numeric keypad, for example.

Description:
Uses keybd_event to manufacture a series of key events matching the passed parameters. The events go to the control with focus. Note that for characters key is always the upper-case version of the character. Sending without any modifier keys will result in a lower-case character, sending it with [ ssShift ] will result in an upper-case character!

USAGE
  PostKeyEx32(VK_DOWN,[], False);                  Down Arrow
  PostKeyEx32(Ord('C'), [ssctrl, ssAlt], False);   Ctrl - Alt  - C
}
type
   TShiftKeyInfo = record
     shift: Byte ;
     vkey: Byte ;
   end;
   ByteSet = set of 0..7 ;
const
   shiftkeys: array [1..3] of TShiftKeyInfo =
     ((shift: Ord(ssCtrl) ; vkey: VK_CONTROL),
     (shift: Ord(ssShift) ; vkey: VK_SHIFT),
     (shift: Ord(ssAlt) ; vkey: VK_MENU)) ;
var
   flag: DWORD;
   bShift: ByteSet absolute shift;
   j: Integer;
begin
   for j := 1 to 3 do
   begin
     if shiftkeys[j].shift in bShift then
       keybd_event(shiftkeys[j].vkey, MapVirtualKey(shiftkeys[j].vkey, 0), 0, 0) ;
   end;
   if specialkey then
     flag := KEYEVENTF_EXTENDEDKEY
   else
     flag := 0;

   keybd_event(key, MapvirtualKey(key, 0), flag, 0) ;
   flag := flag or KEYEVENTF_KEYUP;
   keybd_event(key, MapvirtualKey(key, 0), flag, 0) ;

   for j := 3 downto 1 do
   begin
     if shiftkeys[j].shift in bShift then
       keybd_event(shiftkeys[j].vkey, MapVirtualKey(shiftkeys[j].vkey, 0), KEYEVENTF_KEYUP, 0) ;
   end;
end;



Function GetAppPath:String;
Begin
 //returns the directory where the application is run from
 //and removes any trailing backslash
 if AppDir > '' then begin
    result:=AppDir;
 end else begin
    Result:=ExcludeTrailingPathDelimiter(ExtractFileDir(Application.ExeName));
 end;
end;


Function Question(TheQuestion:String):Boolean;
Begin
 if messagedlg(theQuestion,mtconfirmation,[mbYes,mbNo],0)=6 then
   result:=true
 else
   result:=false;
End;


Procedure Error(theError:String);
Begin
  messagedlg(theError,mterror,[mbok],0);
  PostKeyEx32(VK_Cancel, [], False);
End;


Procedure Information(theInfo:String);
Begin
  messagedlg(theInfo,mtInformation,[mbok],0);
  PostKeyEx32(VK_Cancel, [], False);
End;


Function IntToStrPad(TheInteger, OutputLength:Integer; PadCharacter:String):string;
{purpose: create a string from an integer(TheInteger)
          of specified length(OutputLength) and use the (PadCharacter)
          to fill up the "leading" spaces.}
var
 IntLength:integer;
 i:integer;
 TmpStr:string;
begin
 TmpStr:=trim(IntToStr(TheInteger));
 IntLength:=Length(TmpStr);
 if IntLength < OutputLength then begin
    for i:=IntLength to OutputLength -1 do begin
        TmpStr:=PadCharacter + TmpStr;
    end;
 end;
 result:=trim(TmpStr);
end;


Function  ReplaceCharinStr(sTheStr, sToReplace, sReplacewith : String): String;
Var
  iPos : Integer;
Begin
  iPos := Pos(sToReplace ,sTheStr);
  while (iPos > 0) and ((Length(sTheStr) > 0)) do
  begin
    Delete(sTheStr, iPos, 1);
    Insert(sReplacewith, sTheStr, iPos);
    iPos := Pos(sToReplace ,sTheStr)
  end;
  Result:=sTheStr;
End;

Function CalculateAge(Birthday : TDateTime):Integer;
var
  CurrentDate : TDateTime;
  Month, Day, Year, CurrentYear, CurrentMonth, CurrentDay: Word;
begin
  DecodeDate(Birthday, Year, Month, Day);
  CurrentDate := NOW();
  DecodeDate(CurrentDate, CurrentYear, CurrentMonth, CurrentDay);
  if (Year = CurrentYear) and (Month = CurrentMonth) and (Day = CurrentDay) then
  begin
    Result := 0;
  end
  else
  begin
    Result := CurrentYear - Year;
    if (Month > CurrentMonth) then
      Dec(Result)
    else
    begin
      if Month = CurrentMonth then
        if (Day > CurrentDay) then
          Dec(Result);
    end;
  end;
end;

function split(input:string;schar:char;s:integer):string;
//  Usage -- avar := split('string to break up',' ',2);
//  This will return avar as “to”
var
   i,n:integer;
   schop: string;
begin
   n := 1;
   for i := 1 to length(input) do
   begin
     if (input[i] = schar) then
     begin
       inc(n);
       if n = s then
       split := schop
       else
       schop := '';
       end
     else
       schop := schop + input[i];
     end;
end;

function ThousSeps(dd: Double): String;
Var
  xx: Integer;
  s1: string;
begin
  s1:= FloatToStrF(dd, ffFixed, 11, 0);
  if dd > 999 then
  Begin
    xx:=Length(s1)-2;
    Insert(',', s1, xx);
    if dd > 999999 then
    Begin
     xx:=Length(s1)-6;
     Insert(',', s1, xx);
       if dd > 999999999 then
       Begin
         xx:=Length(s1)-10;
         Insert(',', s1, xx);
       End;
    End;
  End;
  Result:= s1;
end;

Function MyStripout(s1: String):String;
Const
  cInvdComma = #39;
Var
  s2: String;
Begin
  s2:= AnsiReplaceStr(s1, ' ', '');
  s1:= AnsiReplaceStr(s2, ',', '');
  s2:= AnsiReplaceStr(s1, '"', '');
  s2:= AnsiReplaceStr(s2, cInvdComma, '');
  Result:= s2;
End;

End.
