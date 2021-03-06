unit DmoConnectionUserU;

interface

uses
  System.SysUtils, System.Classes, Data.DB,
  Data.Win.ADODB;

type
  TdmoConnectionUser = class(TDataModule)
    conUserMaint: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure conUserMaintBeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmoConnectionUser: TdmoConnectionUser;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDmoConnection }


procedure TdmoConnectionUser.conUserMaintBeforeConnect(Sender: TObject);
var
  vDatasource:TStringList;
  ds:Widestring;
  initString:string;
begin
  initString:='Provider=SQLOLEDB.1;Persist Security Info=False;User ID=sa;'
                  + 'password=1ntelPWD!;Initial Catalog=UserMaint';
  if fileexists('conDataSource.cfg') then begin
    vDataSource:=TStringList.Create;
    vDataSource.LoadFromFile('conDataSource.cfg');
    ds:=vDataSource.Strings[0];
    freeandnil(vDataSource);
    conUserMaint.ConnectionString:= initString + ';Data Source=' + ds;
  end
  else
  begin
    conUserMaint.ConnectionString:= initString + ';Data Source=HARRIER\HARRIER2008R2';
  end;
end;

procedure TdmoConnectionUser.DataModuleCreate(Sender: TObject);
begin
  conUserMaint.Connected := True;
end;


End.
