unit uMain;

interface

uses
  Winapi.Windows,
  Winapi.ShellAPI,
  System.SysUtils,
  System.Classes,
  System.IniFiles,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls;

type
  TfrmMain = class(TForm)
    lbPath: TLabel;
    ePath: TEdit;
    lbUserID: TLabel;
    eUserID: TEdit;
    lbPassword: TLabel;
    ePassword: TEdit;
    lbFileName: TLabel;
    eFileName: TEdit;
    btnFind: TButton;
    OpenDialog1: TOpenDialog;
    btnExecute: TButton;
    btnCancel: TButton;
    procedure btnFindClick(Sender: TObject);
    procedure btnExecuteClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    procedure DBRestore();
    procedure LoadFromFile();
    procedure SaveToFile();
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function GetDosOutput(const ACommandLine: string; Work: string = 'C:\'): string;
var
  SecAtrrs: TSecurityAttributes;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  pCommandLine: array[0..255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  Result := '';
  with SecAtrrs do begin
    nLength := SizeOf(SecAtrrs);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;

  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SecAtrrs, 0);
  try
    with StartupInfo do
    begin
      FillChar(StartupInfo, SizeOf(StartupInfo), 0);
      cb := SizeOf(StartupInfo);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE);
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;

    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + ACommandLine), nil, nil, True, 0, nil, PChar(WorkDir), StartupInfo, ProcessInfo);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := Winapi.Windows.ReadFile(StdOutPipeRead, pCommandLine, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            pCommandLine[BytesRead] := #0;
            Result := Result + pCommandLine;
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
      finally
        CloseHandle(ProcessInfo.hThread);
        CloseHandle(ProcessInfo.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

constructor TfrmMain.Create(AOwner: TComponent);
begin
  inherited;

  LoadFromFile();
end;

destructor TfrmMain.Destroy;
begin
  SaveToFile();

  inherited;
end;

procedure TfrmMain.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnExecuteClick(Sender: TObject);
begin
  DBRestore();
end;

procedure TfrmMain.btnFindClick(Sender: TObject);
begin
  if OpenDialog1.Execute(Handle) then
    eFileName.Text := OpenDialog1.FileName;
end;

procedure TfrmMain.DBRestore();
var
  LCmdLine: string;
  LParams: string;
  LSEI: TShellExecuteInfo;
  LProcessHandle: THandle;
begin
  LCmdLine := Format('"%s\mysql.exe" -u%s -p%s < %s', [ePath.Text, eUserID.Text, ePassword.Text, eFileName.Text]);
  LParams := Format('-u%s -p%s < %s', [eUserID.Text, ePassword.Text, eFileName.Text]);

  GetDosOutput(LCmdLine);
end;

procedure TfrmMain.LoadFromFile;
begin
  with TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini')) do
  begin
    ePath.Text := ReadString('CONFIG', 'PATH', '');
    eUserID.Text := ReadString('CONFIG', 'USERID', 'root');
    ePassword.Text := ReadString('CONFIG', 'PASSWORD', '');

    Free;
  end;
end;

procedure TfrmMain.SaveToFile;
begin
  with TIniFile.Create(ChangeFileExt(ParamStr(0), '.ini')) do
  begin
    WriteString('CONFIG', 'PATH', ePath.Text);
    WriteString('CONFIG', 'USERID', eUserID.Text);
    WriteString('CONFIG', 'PASSWORD', ePassword.Text);

    Free;
  end;
end;

end.
