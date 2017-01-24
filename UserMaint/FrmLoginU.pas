unit FrmLoginU;

interface

uses
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ExtCtrls;

type
  TdlgLogin = class(TForm)
    edtUserName: TEdit;
    edtPassword: TEdit;
    Panel1: TPanel;
    btnOK: TBitBtn;
    btnCancel: TBitBtn;
    txtUser: TStaticText;
    txtPassword: TStaticText;
    Function  ReadProgID(TheProgName: String):Integer;
    procedure edtPasswordChange(Sender: TObject);
    procedure edtUserNameChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtPasswordEnter(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    { Private declarations }
    function GetPassword: string;
    function GetUserName: string;
    function GetUserID: Integer;
    function GetUserDisplayName: string;
    function GetUserEmailAddress: String;
  public
    { Public declarations }
    property UserID: Integer read GetUserID;
    property UserName: string read GetUserName;
    property UserDisplayName: string read GetUserDisplayName;
    property UserEmailAddress: String read GetUserEmailAddress;
  end;

implementation

{$R *.dfm}

uses globals, dmoUserLogInOutU;

{ TdlgLogin }


procedure TdlgLogin.FormCreate(Sender: TObject);
begin
  {$IFDEF DEBUG}
    if sProgDescription =  'MotorLab Reminders' then
    Begin
      edtUserName.Text := 'system';
      edtPassword.Text := 'system';
//      edtUserName.Text := 'Workshop';
//      edtPassword.Text := 'Workshop';
      top  := 150;
      left := 400;
    End;
  {$ENDIF}
  btnOK.Enabled := True;
  btnOK.Visible := True;
End;


procedure TdlgLogin.btnCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

Procedure TdlgLogin.btnOKClick(Sender: TObject);
begin
  If dmoUserLogInOut.ReadUserPWD(edtUserName.Text, edtPassword.Text) = False Then
  Begin
    Error ('Invalid Password');
    edtPassword.Text := '';
    edtPassword.SetFocus;
  End
  Else
  Begin
    dmoUserLogInOut.SetUserLoggedIn(True);
    ModalResult := mrOk;
  End;
end;


procedure TdlgLogin.edtPasswordChange(Sender: TObject);
begin
  btnOK.Enabled := (Length(edtUserName.Text) > 0) AND (Length(edtPassword.Text) > 0);
End;


procedure TdlgLogin.edtPasswordEnter(Sender: TObject);
begin
  if Length(edtUserName.Text) > 0 then
  Begin
    LogInUserID := dmoUserLogInOut.ReadUserName(UserName);
    If LogInUserID = 0 then
    Begin
      Error ('Invalid User');
      ModalResult := mrNone;
      edtUserName.SetFocus;
    End;
  End;
End;


procedure TdlgLogin.edtUserNameChange(Sender: TObject);
begin
  btnOK.Enabled := (Length(edtUserName.Text) > 0) AND (Length(edtPassword.Text) > 0);
end;


function TdlgLogin.GetPassword: string;
begin
  Result := edtPassword.Text;
end;

function TdlgLogin.GetUserDisplayName: string;
begin
  Result := dmoUserLogInOut.qrySysUser.FieldByName('UserDisplayName').AsString;
End;

function TdlgLogin.GetUserEmailAddress: String;
begin
  Result := dmoUserLogInOut.qrySysUser.FieldByName('UserEmailAddress').AsString;
end;

function TdlgLogin.GetUserID: Integer;
begin
  Result := dmoUserLogInOut.qrySysUser.FieldByName('UserID').AsInteger;
end;

function TdlgLogin.GetUserName: string;
begin
  Result := edtUserName.Text;
End;


function TdlgLogin.ReadProgID(TheProgName: String): Integer;
begin
  Result:= dmoUserLogInOut.SelectProgID(TheProgName);  // Needed to test valid user
end;

End.
