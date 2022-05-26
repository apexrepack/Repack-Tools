//----------This Installer Uses Inno Setup Unicode Version----------\\
#define AppName "Your Game Name"
#define Name "Your Game Name"
#define Shortname "Your Game Name"
#define AppPublisher "Your Repack Name"
#define AppVersion "Your Game Version"
#define AppExec "Your Game Launcher Name"
#define AppSize "Your Game Space"   
#define Spacesize "Your Game Space"                
#define SetupName "Setup"

#define PrecompVer "Inside" 

[Setup]
PrivilegesRequired=Admin
AppName={#AppName}
AppPublisher={#AppPublisher}
AppVersion={#AppVersion}
AppComments="Add Your Repack Uninstaller Any Comments"
AppId={#Name} ~ {#AppPublisher}
DefaultDirName={pf} "Add Your Game Install Directory"{#AppName}
DefaultGroupName={#AppName}  
OutputBaseFilename={#SetupName}
OutputDir=Output
Compression=lzma
SolidCompression=yes
SetupIconFile=Style\Setup.ico
WizardImageFile=Style\Background.bmp
WizardSmallImageFile=Style\smallbitmap.bmp
AppCopyright="Add Your Repack Copyright"
UninstallDisplayName={#Name}
UninstallDisplayIcon={app}\Uninstall\unins000.exe
UninstallDisplaySize={#AppSize}000000
Uninstallable=True
DirExistsWarning=True
DiskSpanning=no
EnableDirDoesntExistWarning=no
InternalCompressLevel=max

[Icons]
Name: {group}\Uninstall {#AppName}; Filename: {app}Uninstall\unins000.exe; WorkingDir: {app}; Check: CheckError
Name: {group}\{#AppName}; Filename: {app}\{#AppExec}; WorkingDir: {app}; Check: CheckError
Name: {commondesktop}\{#AppName}; Filename: {app}\{#AppExec}; WorkingDir: {app}; Check: CheckError

[Files]
Source: Include\*.*; DestDir: {tmp}; Flags: dontcopy
Source: Style\*.*; DestDir: {tmp}; Flags: dontcopy

[Messages]
SetupWindowTitle=                                                            Welcome To The APEX Repack Games
  
[CustomMessages]
SoundCtrlButtonCaptionSoundOn=Music on
SoundCtrlButtonCaptionSoundOff=Music off 

[Languages]
Name: eng; MessagesFile: compiler:Default.isl

[Components]
Name: "directx"; Description: "Install DirectX"
Name: "visualc"; Description: "Install Visual C++"
Name: "nvidiaphysx"; Description: "Install Nvidia Physx"
Name: "framework"; Description: "Install Framework"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[UninstallDelete]
Type: filesandordirs; Name: {app}

[Code]
const
  BASS_SAMPLE_LOOP = 4;
  BASS_ACTIVE_STOPPED = 0;
  BASS_ACTIVE_PLAYING = 1;
  BASS_ACTIVE_STALLED = 2;
  BASS_ACTIVE_PAUSED  = 3;
  BASS_UNICODE = $80000000;
  BASS_CONFIG_GVOL_STREAM = 5;
const
  #ifndef UNICODE
    EncodingFlag = 0;
  #else
    EncodingFlag = BASS_UNICODE;
  #endif
type
  HSTREAM = DWORD;

function BASS_Init(device: LongInt; freq, flags: DWORD;
  win: HWND; clsid: Cardinal): BOOL;
  external 'BASS_Init@files:bass.dll stdcall';
function BASS_StreamCreateFile(mem: BOOL; f: string; offset1: DWORD;
  offset2: DWORD; length1: DWORD; length2: DWORD; flags: DWORD): HSTREAM;
  external 'BASS_StreamCreateFile@files:bass.dll stdcall';
function BASS_Start: BOOL;
  external 'BASS_Start@files:bass.dll stdcall';
function BASS_Pause: BOOL;
  external 'BASS_Pause@files:bass.dll stdcall';
function BASS_ChannelPlay(handle: DWORD; restart: BOOL): BOOL;
  external 'BASS_ChannelPlay@files:bass.dll stdcall';
function BASS_SetConfig(option: DWORD; value: DWORD ): BOOL;
  external 'BASS_SetConfig@files:bass.dll stdcall';
function BASS_ChannelIsActive(handle: DWORD): DWORD;
  external 'BASS_ChannelIsActive@files:bass.dll stdcall';
function BASS_Free: BOOL;
  external 'BASS_Free@files:bass.dll stdcall';

var
  SoundStream: HSTREAM;
  SoundCtrlButton: TNewButton;

procedure SoundCtrlButtonClick(Sender: TObject);
begin
  case BASS_ChannelIsActive(SoundStream) of
    BASS_ACTIVE_PLAYING:
    begin
      if BASS_Pause then
        SoundCtrlButton.Caption :=
          ExpandConstant('{cm:SoundCtrlButtonCaptionSoundOn}');
    end;
    BASS_ACTIVE_PAUSED:
    begin
      if BASS_Start then
        SoundCtrlButton.Caption :=
          ExpandConstant('{cm:SoundCtrlButtonCaptionSoundOff}');
    end;
  end;
end;

{ RedesignWizardFormBegin } // Don't remove this line!
// Don't modify this section. It is generated automatically.
procedure RedesignWizardForm;
begin
  with WizardForm.ProgressGauge do
  begin
    Height := ScaleY(13);
  end;

{ ReservationBegin }
  // This part is for you. Add your specialized code here.

{ ReservationEnd }
end;
// Don't modify this section. It is generated automatically.
{ RedesignWizardFormEnd } // Don't remove this line!


type
#ifdef UNICODE
 PChar = PAnsiChar;
#endif
const
  PCFonFLY=true;
  notPCFonFLY=false;
var
  LabelPct1,LabelCurrFileName,LabelTime1,LabelTime2,LabelTime3: TLabel;
  ISDoneProgressBar1: TNewProgressBar;
  MyCancelButton: TButton;
  ISDoneCancel:integer;
  ISDoneError:boolean;
  PCFVer:double;

type
  TCallback = function (OveralPct,CurrentPct: integer;CurrentFile,TimeStr1,TimeStr2,TimeStr3:PAnsiChar): longword;

function WrapCallback(callback:TCallback; paramcount:integer):longword;external 'wrapcallback@files:ISDone.dll stdcall delayload';

function ISArcExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath, ExtractedPath: AnsiString; DeleteInFile:boolean; Password, CfgFile, WorkPath: AnsiString; ExtractPCF: boolean ):boolean; external 'ISArcExtract@files:ISDone.dll stdcall delayload';
function IS7ZipExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath: AnsiString; DeleteInFile:boolean; Password: AnsiString):boolean; external 'IS7zipExtract@files:ISDone.dll stdcall delayload';
function ISRarExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutPath: AnsiString; DeleteInFile:boolean; Password: AnsiString):boolean; external 'ISRarExtract@files:ISDone.dll stdcall delayload';
function ISPrecompExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString; DeleteInFile:boolean):boolean; external 'ISPrecompExtract@files:ISDone.dll stdcall delayload';
function ISSRepExtract(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString; DeleteInFile:boolean):boolean; external 'ISSrepExtract@files:ISDone.dll stdcall delayload';
function ISxDeltaExtract(CurComponent:Cardinal; PctOfTotal:double; minRAM,maxRAM:integer; InName, DiffFile, OutFile: AnsiString; DeleteInFile, DeleteDiffFile:boolean):boolean; external 'ISxDeltaExtract@files:ISDone.dll stdcall delayload';
function ISPackZIP(CurComponent:Cardinal; PctOfTotal:double; InName, OutFile: AnsiString;ComprLvl:integer; DeleteInFile:boolean):boolean; external 'ISPackZIP@files:ISDone.dll stdcall delayload';
function ShowChangeDiskWindow(Text, DefaultPath, SearchFile:AnsiString):boolean; external 'ShowChangeDiskWindow@files:ISDone.dll stdcall delayload';

function Exec2 (FileName, Param: PAnsiChar;Show:boolean):boolean; external 'Exec2@files:ISDone.dll stdcall delayload';
function ISFindFiles(CurComponent:Cardinal; FileMask:AnsiString; var ColFiles:integer):integer; external 'ISFindFiles@files:ISDone.dll stdcall delayload';
function ISPickFilename(FindHandle:integer; OutPath:AnsiString; var CurIndex:integer; DeleteInFile:boolean):boolean; external 'ISPickFilename@files:ISDone.dll stdcall delayload';
function ISGetName(TypeStr:integer):PAnsichar; external 'ISGetName@files:ISDone.dll stdcall delayload';
function ISFindFree(FindHandle:integer):boolean; external 'ISFindFree@files:ISDone.dll stdcall delayload';
function ISExec(CurComponent:Cardinal; PctOfTotal,SpecifiedProcessTime:double; ExeName,Parameters,TargetDir,OutputStr:AnsiString;Show:boolean):boolean; external 'ISExec@files:ISDone.dll stdcall delayload';

function SrepInit(TmpPath:PAnsiChar;VirtMem,MaxSave:Cardinal):boolean; external 'SrepInit@files:ISDone.dll stdcall delayload';
function PrecompInit(TmpPath:PAnsiChar;VirtMem:cardinal;PrecompVers:single):boolean; external 'PrecompInit@files:ISDone.dll stdcall delayload';
function FileSearchInit(RecursiveSubDir:boolean):boolean; external 'FileSearchInit@files:ISDone.dll stdcall delayload';
function ISDoneInit(RecordFileName:AnsiString; TimeType,Comp1,Comp2,Comp3:Cardinal; WinHandle, NeededMem:longint; callback:TCallback):boolean; external 'ISDoneInit@files:ISDone.dll stdcall';
function ISDoneStop:boolean; external 'ISDoneStop@files:ISDone.dll stdcall';
function ChangeLanguage(Language:AnsiString):boolean; external 'ChangeLanguage@files:ISDone.dll stdcall delayload';
function SuspendProc:boolean; external 'SuspendProc@files:ISDone.dll stdcall';
function ResumeProc:boolean; external 'ResumeProc@files:ISDone.dll stdcall';

function ProgressCallback(OveralPct,CurrentPct: integer;CurrentFile,TimeStr1,TimeStr2,TimeStr3:PAnsiChar): longword;
begin
  if OveralPct<=1000 then ISDoneProgressBar1.Position := OveralPct;
  LabelPct1.Caption := IntToStr(OveralPct div 10)+'.'+chr(48 + OveralPct mod 10)+'%';
  LabelCurrFileName.Caption:=' Installing Game: '+MinimizePathName(CurrentFile, LabelCurrFileName.Font, LabelCurrFileName.Width-ScaleX(100));
  LabelTime1.Caption:=' Time Elapsed: '+TimeStr2;
  LabelTime2.Caption:='Time Remaining: '+TimeStr1;
 // LabelTime3.Caption:='Installing time:'+TimeStr3;
  Result := ISDoneCancel;
end;

procedure CancelButtonOnClick(Sender: TObject);
begin
  SuspendProc;
  if MsgBox(SetupMessage(msgExitSetupMessage), mbConfirmation, MB_YESNO) = IDYES then ISDoneCancel:=1;
  ResumeProc;
end;

procedure HideControls;
begin
  WizardForm.FileNamelabel.Hide;
  ISDoneProgressBar1.Hide;
  LabelPct1.Hide;
  LabelCurrFileName.Hide;
  LabelTime1.Hide;
  LabelTime2.Hide;
  MyCancelButton.Hide;
end;

procedure CreateControls;
var PBTop:integer;
begin
  PBTop:=ScaleY(150);
  ISDoneProgressBar1 := TNewProgressBar.Create(WizardForm);
  with ISDoneProgressBar1 do begin
    Parent   := WizardForm;
    Height   := 25;
    Left     := ScaleX(77);
    Top      := PBTop;
    Width    := ScaleX(500);
    Max      := 1000;
  end;
  LabelCurrFileName := TLabel.Create(WizardForm);
  with LabelCurrFileName do begin
    Parent   := WizardForm;
    AutoSize := False;
    Width    := ISDoneProgressBar1.Width+ScaleX(30);
    Left     := ISDoneProgressBar1.Left;
    Top      := PBTop-20;
  end;

  LabelTime1 := TLabel.Create(WizardForm);
  with LabelTime1 do begin
    Parent   := WizardForm;
    AutoSize := False;
    Width    := ISDoneProgressBar1.Width div 2;
    Left     := ISDoneProgressBar1.Left;
    Top      := PBTop + ScaleY(30);
  end;
  LabelTime2 := TLabel.Create(WizardForm);
  with LabelTime2 do begin
    Parent   := WizardForm;
    AutoSize := False;
    Width    := LabelTime1.Width+ScaleX(40);
    Left     := 400;
    Top      := LabelTime1.Top;
  end;
  LabelPct1 := TLabel.Create(WizardForm);
  with LabelPct1 do begin
    Parent    := WizardForm;
    AutoSize  := true;
    Font.Height:=-24;
    Left      := ISDoneProgressBar1.Left -33 + ISDoneProgressBar1.Width div 2;
    Top       := ISDoneProgressBar1.Top + ScaleY(70);
    //Width     := ScaleX(80);
  end;
//  LabelTime3 := TLabel.Create(WizardForm);
//  with LabelTime3 do begin
//    Parent   := WizardForm;
//    AutoSize := False;
//    Width    := 300;
//    Left     := 180;
//    Top      := 200;
//  end;
  MyCancelButton:=TButton.Create(WizardForm);
  with MyCancelButton do begin
    Parent:=WizardForm;
    Width:=ScaleX(150);
    Caption:='Cancel';
    Left:=ScaleX(347);
    Height:=ScaleX(30);
    Left:=(480);
    Top:=WizardForm.cancelbutton.top;
    OnClick:=@CancelButtonOnClick;
  end;
end;


function CheckError:boolean;
begin
  result:= not ISDoneError;
end;

// Importing LoadSkin API from ISSkin.DLL
procedure LoadSkin(lpszPath: PAnsiChar; lpszIniFileName: PAnsiChar);
external 'LoadSkin@{tmp}\isskin.dll stdcall delayload';

// Importing UnloadSkin API from ISSkin.DLL
procedure UnloadSkin;
external 'UnloadSkin@{tmp}\isskin.dll stdcall delayload';

// Importing ShowWindow Windows API from User32.DLL
function ShowWindow(hWnd: Integer; uType: Integer): Integer;
external 'ShowWindow@user32.dll stdcall';

var
  WelcomeLbl,DirLbl,GroupLbl,TasksLbl,FreeSpaceLabel,NeedSpaceLabel,GameSpaceLabel,PartitionSpaceLabel,Status: TLabel;
  DirBevel,GroupBevel,TasksBevel,TasksSeparateBevel,Bevel1,Bevel11,Bevel2,Bevel3,Bevel4,Bevel5,Bevel6,Bevel7,Bevel8,Bevel9,Bevel20,Bevel21,Bevel22,Bevel23: TBevel;
  FreeMB,TotalMB: cardinal;

function InitializeSetup1(): Boolean;
begin
  ExtractTemporaryFile('isskin.dll');
	ExtractTemporaryFile('skin.cjstyles');
	LoadSkin(ExpandConstant('{tmp}\skin.cjstyles'), '');
	Result := True;
end;

Function NumToStr(Float: Extended): String;
Begin
  Result:= Format('%.2n', [Float]); StringChange(Result, ',', '.');
  while ((Result[Length(Result)] = '0') or (Result[Length(Result)] = '.')) and (Pos('.', Result) > 0) do
  SetLength(Result, Length(Result)-1);
End;

Function MbOrTb(Byte: Extended): String;
begin
if Byte < 1024 then Result:= NumToStr(Byte) + ' MB' else
  if Byte/1024 < 1024 then Result:= NumToStr(round(Byte/1024*100)/100) + ' GB' else
     Result:= NumToStr(round((Byte/(1024*1024))*100)/100) + ' TB'
end;

procedure GetFreeSpaceCaption(Sender: TObject);
var Path: String;
begin
  Path := ExtractFileDrive(WizardForm.DirEdit.Text);
  GetSpaceOnDisk(Path, True, FreeMB, TotalMB);
  PartitionSpaceLabel.Caption:= ExpandConstant('Partition Space : ') + MbOrTb(TotalMB);
  FreeSpaceLabel.Caption := ExpandConstant('Free Space : ') + MbOrTb(FreeMB) + ' (' + IntToStr((FreeMB * 100) div TotalMB) + '%)';
  GameSpaceLabel.Caption := ExpandConstant('Game Space : ') + MbOrTb({#AppSize});
  NeedSpaceLabel.Caption := ExpandConstant('Total Needed Space : ') + MbOrTb({#AppSize});
  if (FreeMB<{#AppSize}) then
    FreeSpaceLabel.Font.Color:=clRed
  else
    PartitionSpaceLabel.Font.Color:=NeedSpaceLabel.Font.Color;
    WizardForm.NextButton.Enabled:=FreeMB>{#AppSize};
end;

var
  DirectXCB,VisualCCB,NvidiaPhysx,Framework,IconCB: TNewCheckBox;
//---COMPONENTS POSITION CONTROL---\\
procedure Tasks;
begin
  TasksBevel := TBevel.Create(WizardForm);
  with TasksBevel do
  begin
    Parent := WizardForm;
    Left := ScaleX(90);
    Top := ScaleY(150);
    Width := ScaleX(470);
    Height := ScaleY(73);
  end;
//------------------------\\

//---Top---\\
  Bevel20 := TBevel.Create(WizardForm);
  with Bevel20 do
  begin
    Parent := WizardForm;
    Left := ScaleX(92);
    Top := ScaleY(150);
    Width := ScaleX(470);
    Height := ScaleY(2);
  end;
//---Bottom---\\
    Bevel21 := TBevel.Create(WizardForm);
  with Bevel21 do
  begin
    Parent := WizardForm;
    Left := ScaleX(92);
    Top := ScaleY(308);
    Width := ScaleX(470);
    Height := ScaleY(2);
  end;
//---Left---\\
  Bevel22 := TBevel.Create(WizardForm);
  with Bevel22 do
  begin
    Parent := WizardForm;
    Left := ScaleX(92);
    Top := ScaleY(152);
    Width := ScaleX(2);
    Height := ScaleY(158);
  end;
//---Right---\\
  Bevel23 := TBevel.Create(WizardForm);
  with Bevel23 do
  begin
    Parent := WizardForm;
    Left := ScaleX(560);
    Top := ScaleY(152);
    Width := ScaleX(2);
    Height := ScaleY(156);
  end;
//------------------------\\
  
  DirectXCB := TNewCheckBox.Create(WizardForm);
  with DirectXCB do
  begin
    Parent := WizardForm;
    Left :=(112);
    Top :=(170);
    Width := ScaleX(265);
    Height := ScaleY(17);
    Caption:='Install DirectX';
  end;
  
  VisualCCB := TNewCheckBox.Create(WizardForm);
  with VisualCCB do
  begin
    Parent := WizardForm;
    Left :=(112);
    Top :=(190);
    Width := ScaleX(265);
    Height := ScaleY(17);
    Caption := 'Install Visual C ++';
  end;
  
  NvidiaPhysx := TNewCheckBox.Create(WizardForm);
  with NvidiaPhysx do
  begin
    Parent := WizardForm;
    Left :=(112);
    Top :=(210);
    Width := ScaleX(265);
    Height := ScaleY(17);
    Caption:='Install Nvidia Physx';
  end;
  
  Framework := TNewCheckBox.Create(WizardForm);
  with Framework do
  begin
    Parent := WizardForm;
    Left :=(112);
    Top :=(230);
    Width := ScaleX(265);
    Height := ScaleY(17);
    Caption:='Install Framework';
  end;
  
  TasksSeparateBevel := TBevel.Create(WizardForm);
  with TasksSeparateBevel do
  begin
    Parent := WizardForm;
    Left :=(10);
    Top :=(260);
    Width := TasksBevel.Width - 0;
    Height := ScaleY(2);
    Width := ScaleX(440);
    Left := ScaleX(107);
  end;
  
  IconCB := TNewCheckBox.Create(WizardForm);
  with IconCB do
  begin
    Parent := WizardForm;
    Left := (112);
    Top :=(275);
    Width := ScaleX(255);
    Height := ScaleY(17);
    Caption := 'Create Desktop Shortcut';
  end;
end;

//-----------------------------------\\

procedure LogoLabelOnClick(Sender: TObject);
var
  ErrorCode: Integer;
  begin
end;

procedure InitializeWizard1();
begin
  WizardForm.WizardBitmapImage2;
  WizardForm.WizardBitmapImage2;
  WizardForm.ClientWidth:=654;
  WizardForm.ClientHeight:=402;
  WizardForm.InnerNotebook.Hide;
  WizardForm.OuterNotebook.Hide;
  WizardForm.WizardBitmapImage.Stretch:=True;
  WizardForm.WizardBitmapImage.Parent:=WizardForm;
  ExtractTemporaryFile ('logo.bmp');
  WizardForm.WizardBitmapImage2.Width := ScaleX(230);
  WizardForm.WizardBitmapImage2.Height := ScaleX(55);
  WizardForm.WizardBitmapImage2.Top:=340;
  WizardForm.WizardBitmapImage2.Left:=5;
  WizardForm.WizardBitmapImage2.Bitmap.LoadFromFile(ExpandConstant('{tmp}\logo.bmp'));
  WizardForm.WizardBitmapImage2.Parent:=WizardForm;
  WizardForm.WizardSmallBitmapImage.Stretch:=True;
  WizardForm.WizardSmallBitmapImage.Parent:=WizardForm;
  WizardForm.WizardSmallBitmapImage.SetBounds(0,0,WizardForm.ClientWidth,90);
  WizardForm.Bevel1.Parent:=WizardForm;
  WizardForm.Bevel1.Top:=90;
  WizardForm.Bevel1.Width:=WizardForm.ClientWidth;
  WizardForm.Bevel.Parent:=WizardForm;
  WizardForm.Bevel.Top:=330;
  WizardForm.Bevel.Width:=WizardForm.ClientWidth;
  WizardForm.SelectDirBitmapImage.Parent:=WizardForm;
  WizardForm.SelectDirBitmapImage.Top:=125;
  WizardForm.SelectDirBitmapImage.Left:=40;
  WizardForm.DirEdit.Parent:=WizardForm;
  WizardForm.DirEdit.Top:=130;
  WizardForm.DirEdit.Left:=75;
  WizardForm.DirEdit.Width:=430;
  WizardForm.DirEdit.OnChange:=@GetFreeSpaceCaption;
  WizardForm.DirBrowseButton.Parent:=WizardForm;
  WizardForm.DirBrowseButton.Top:=125;
  WizardForm.DirBrowseButton.Left:=515;
  WizardForm.DirBrowseButton.Width:=90;
  WizardForm.DirBrowseButton.Height:=30;
  WizardForm.GroupEdit.Parent:=WizardForm;
  WizardForm.GroupEdit.Top:=255;
  WizardForm.GroupEdit.Left:=75;
  WizardForm.GroupEdit.Width:=430;
  WizardForm.GroupBrowseButton.Parent:=WizardForm;
  WizardForm.GroupBrowseButton.Top:=250;
  WizardForm.GroupBrowseButton.Left:=515;
  WizardForm.GroupBrowseButton.Width:=90;
  WizardForm.GroupBrowseButton.Height:=30;
  WizardForm.NoIconsCheck.Parent:=WizardForm;
  WizardForm.NoIconsCheck.Left:=75;
  WizardForm.NoIconsCheck.Top:=285;
  WizardForm.SelectGroupBitmapImage.Parent:=WizardForm;
  WizardForm.SelectGroupBitmapImage.Top:=250;
  WizardForm.SelectGroupBitmapImage.Left:=40;
  WizardForm.WizardBitmapImage.SetBounds(0,0,WizardForm.ClientWidth,330);
  WizardForm.NextButton.SetBounds(525,347,100,30);
  WizardForm.CancelButton.SetBounds(420,347,100,30);
  WizardForm.BackButton.SetBounds(315,347,100,30);
  
  WelcomeLbl:=TLabel.Create(WizardForm);
  With WelcomeLbl do begin
    Transparent:=true;
    Parent:=WizardForm;
    Alignment:=taCenter;
    Caption:='Welcome To The {#AppName} Game Setup Wizard' + #13#10#13#10 + 'Its Recomended That You Close All Other Applications Before Continuing.' + #13#10#13#10 + 'Click "Next" To Continue';
    Font.Color:=clWhite;
    Font.Size:=9;
    SetBounds(126,205,400,90);
  end;
//
  Tasks;
  DirBevel := TBevel.Create(WizardForm);
  with DirBevel do
  begin
    Parent := WizardForm;
    Left := ScaleX(28);
    Top := ScaleY(110);
    Width := ScaleX(594);
    Height := ScaleY(110);
  end;

//-----Bevel Line Page 2 Bottom-----\\

//---Top---\\
  Bevel3 := TBevel.Create(WizardForm);
  with Bevel3 do
  begin
    Parent := WizardForm;
    Left := ScaleX(27);
    Top := ScaleY(235);
    Width := ScaleX(594);
    Height := ScaleY(2);
  end;
//---Bottom---\\
    Bevel4 := TBevel.Create(WizardForm);
  with Bevel4 do
  begin
    Parent := WizardForm;
    Left := ScaleX(27);
    Top := ScaleY(313);
    Width := ScaleX(595);
    Height := ScaleY(2);
  end;
//---Left---\\
  Bevel5 := TBevel.Create(WizardForm);
  with Bevel5 do
  begin
    Parent := WizardForm;
    Left := ScaleX(27);
    Top := ScaleY(236);
    Width := ScaleX(2);
    Height := ScaleY(78);
  end;
//---Right---\\
  Bevel6 := TBevel.Create(WizardForm);
  with Bevel6 do
  begin
    Parent := WizardForm;
    Left := ScaleX(620);
    Top := ScaleY(235);
    Width := ScaleX(2);
    Height := ScaleY(79);
  end;
//------------------------\\

//-----Bevel Line Page 2 Top-----\\

//---Top---\\
    Bevel7 := TBevel.Create(WizardForm);
  with Bevel7 do
  begin
    Parent := WizardForm;
    Left := ScaleX(27);
    Top := ScaleY(110);
    Width := ScaleX(595);
    Height := ScaleY(2);
  end;
//---Bottom---\\
    Bevel8 := TBevel.Create(WizardForm);
  with Bevel8 do
  begin
    Parent := WizardForm;
    Left := ScaleX(27);
    Top := ScaleY(250);
    Width := ScaleX(595);
    Height := ScaleY(2);
  end;
//---Right---\\
    Bevel9 := TBevel.Create(WizardForm);
  with Bevel9 do
  begin
    Parent := WizardForm;
    Left := ScaleX(620);
    Top := ScaleY(110);
    Width := ScaleX(2);
    Height := ScaleY(108);
  end;
//---Left---\\
    Bevel11 := TBevel.Create(WizardForm);
  with Bevel11 do
  begin
    Parent := WizardForm;
    Left := ScaleX(27);
    Top := ScaleY(111);
    Width := ScaleX(2);
    Height := ScaleY(109);
  end;

//------------------------\\
  Status:=TLabel.Create(WizardForm);
  With Status do begin
    //Transparent:=true;
    Parent:=WizardForm;
    Alignment:=taCenter;
    //Font.Color:=clWhite;
    Font.Height:=-15;
    SetBounds(0,218,650,30);
  end;

  DirLbl:=TLabel.Create(WizardForm);
  With DirLbl do begin
    //Transparent:=true;
    Parent:=WizardForm;
    //Alignment:=taCenter;
    Caption:='Install The Game Into The Following Folder';
    Font.Color:=clWhite;
    SetBounds(52,105,251,15);
  end;
  GroupLbl:=TLabel.Create(WizardForm);
  With GroupLbl do begin
    //Transparent:=true;
    Parent:=WizardForm;
    //Alignment:=taCenter;
    Caption:='Create Shortcuts In The Following Start Menu';
    Font.Color:=clWhite;
    SetBounds(52,230,235,15);
  end;
  TasksLbl:=TLabel.Create(WizardForm);
  With TasksLbl do begin
    //Transparent:=true;
    Parent:=WizardForm;
    //Alignment:=taCenter;
    Caption:='Select To All Redist' + #13#10 + 'Install Button To Click Now Then Next When You Are Ready To Continue.';
    //Font.Color:=clWhite;
    SetBounds(125,105,407,30);
  end;
//---PARTITION SPACE---\\
  PartitionSpaceLabel:=TLabel.Create(WizardForm);
  With PartitionSpaceLabel do begin
    //Transparent:=true;
    Parent:=WizardForm;
    //Alignment:=taCenter;
    //Font.Color:=clWhite;
    Font.Height:=-13;
    SetBounds(75,160,200,30);
  end;
//---FREE SPACE---\\
  FreeSpaceLabel:=TLabel.Create(WizardForm);
  With FreeSpaceLabel do begin
    //Transparent:=true;
    Parent:=WizardForm;
    //Alignment:=taCenter;
    //Font.Color:=clWhite;
    Font.Height:=-13;
    SetBounds(335,160,200,30);
  end;
//---GAME SPACE---\\
  GameSpaceLabel:=TLabel.Create(WizardForm);
  With GameSpaceLabel do begin
    //Transparent:=true;
    Parent:=WizardForm;
    //Alignment:=taCenter;
    //Font.Color:=clWhite;
    Font.Height:=-13;
    SetBounds(75,190,200,30);
  end;
//---Total Needed Space---\\
  NeedSpaceLabel:=TLabel.Create(WizardForm);
  With NeedSpaceLabel do begin
    //Transparent:=true;
    Parent:=WizardForm;
    //Alignment:=taCenter;
    //Font.Color:=clWhite;
    Font.Height:=-13;
    SetBounds(335,190,200,30);
  end;
end;

Procedure HideComponents();
begin
    WizardForm.WizardSmallBitmapImage.Hide;
    WizardForm.Bevel1.Hide;
    DirBevel.Hide;
    Bevel3.Hide;
    Bevel4.Hide;
    Bevel5.Hide;
    Bevel6.Hide;
    Bevel7.Hide;
    Bevel8.Hide;
    Bevel9.Hide;
    Bevel11.Hide;
    Bevel20.Hide;
    Bevel21.Hide;
    Bevel22.Hide;
    Bevel23.Hide;
    TasksBevel.Hide;
    DirLbl.Hide;
    GroupLbl.Hide;
    TasksLbl.Hide;
    DirectXCB.Hide;
    VisualCCB.Hide;
    NvidiaPhysx.Hide;
    Framework.Hide;
    IconCB.Hide;
    WizardForm.SelectDirBitmapImage.Hide;
    WizardForm.SelectGroupBitmapImage.Hide;
    WizardForm.DirEdit.Hide;
    WizardForm.GroupEdit.Hide;
    WizardForm.DirBrowseButton.Hide;
    WizardForm.GroupBrowseButton.Hide;
    WizardForm.NoIconsCheck.Hide;
    WizardForm.WizardBitmapImage.Hide;
    WelcomeLbl.Hide;
//    WizardForm.ComponentsList.Hide;
//    WizardForm.TasksList.Hide;
    TasksSeparateBevel.Hide;
    PartitionSpaceLabel.Hide;
    FreeSpaceLabel.Hide;
    GameSpaceLabel.Hide;
    NeedSpaceLabel.Hide;
    Status.Hide;
end;

procedure CurStepChanged1(CurStep: TSetupStep);
var Comps1,Comps2,Comps3, TmpValue:cardinal;
    FindHandle1,ColFiles1,CurIndex1,tmp:integer;
    ExecError:boolean;
    InFilePath,OutFilePath,OutFileName:PAnsiChar;
begin
  if CurStep = ssInstall then begin  //If necessary, you can change to ssPostInstall
    WizardForm.ProgressGauge.Hide;
    WizardForm.CancelButton.Hide;
    CreateControls;
    WizardForm.StatusLabel.Caption:='Installing Game';
    ISDoneCancel:=0;

#ifdef PrecompVer
#if PrecompVer == "0.38"
ExtractTemporaryFile('precomp038.exe');
#endif
#if PrecompVer == "0.40"
ExtractTemporaryFile('precomp040.exe');
#endif
#if PrecompVer == "0.41"
ExtractTemporaryFile('precomp041.exe');
#endif
#if PrecompVer == "0.42"
ExtractTemporaryFile('precomp042.exe');
#endif
#if PrecompVer == "0.43"
ExtractTemporaryFile('precomp043.exe');
#endif
#if PrecompVer == "Inside"
ExtractTemporaryFile('CLS-precomp.dll');
ExtractTemporaryFile('CLS-MSC.dll');
ExtractTemporaryFile('CLS-srep.dll');
ExtractTemporaryFile('precomp.exe');
#endif
#endif
ExtractTemporaryFile('arc.ini');
ExtractTemporaryFile('facompress.dll');
ExtractTemporaryFile('facompress_mt.dll');
ExtractTemporaryFile('XDelta3.dll');
ExtractTemporaryFile('7z.dll');
ExtractTemporaryFile('PackZIP.exe');
ExtractTemporaryFile('english.ini');
ExtractTemporaryFile('FreeArc-LZMA-x64.exe');
ExtractTemporaryFile('srep.exe');
ExtractTemporaryFile('srep64.exe');
ExtractTemporaryFile('unarc.dll');
ExtractTemporaryFile('packjpg_dll.dll');
ExtractTemporaryFile('packjpg_dll1.dll');
ExtractTemporaryFile('zlib1.dll');

    Comps1:=0; Comps2:=0; Comps3:=0;
#ifdef Components
    TmpValue:=1;
    if IsComponentSelected('text\rus') then Comps1:=Comps1+TmpValue;     //component 1
    TmpValue:=TmpValue*2;
    if IsComponentSelected('text\eng') then Comps1:=Comps1+TmpValue;     //component 2
    TmpValue:=TmpValue*2;
    if IsComponentSelected('voice\rus') then Comps1:=Comps1+TmpValue;    //component 3
    TmpValue:=TmpValue*2;
    if IsComponentSelected('voice\eng') then Comps1:=Comps1+TmpValue;    //component 4
#endif

#ifdef precomp
  PCFVer:={#precomp};
#else
  PCFVer:=0;
#endif
    ISDoneError:=true;
    if ISDoneInit(ExpandConstant('{src}\records.inf'), $F777, Comps1,Comps2,Comps3, MainForm.Handle, 512, @ProgressCallback) then begin
      repeat
        ChangeLanguage('english');
        if not SrepInit('',512,0) then break;
        if not PrecompInit('',128,PCFVer) then break;
        if not FileSearchInit(true) then break;
        #include 'Archives.ini'
        ISDoneError:=false;
      until true;
      ISDoneStop;
    end;
    HideControls;
    WizardForm.CancelButton.Visible:=true;
    WizardForm.CancelButton.Enabled:=false;
    Status.Show;
  end;
  if CurStep=ssPostInstall then begin
    if DirectXCB.Checked then begin
      Status.Caption:='Installing DirectX...';
      Status.Left := 200;
      Status.Top := 200;
      Status.Width := 223;
      Status.Height := 20;
      Exec2(ExpandConstant('{src}\Redist\DirectX\DXSETUP.exe'),'/q',false);
    end;
    if NvidiaPhysx.Checked then begin
      Status.Caption:='Installing Nvidia Physx...';
      Status.Left := 200;
      Status.Top := 200;
      Status.Width := 227;
      Status.Height := 20;
      Exec2(ExpandConstant('{src}\Redist\PhysX.msi'),'/q',false);
    end;
    if VisualCCB.Checked then begin
      Status.Caption:='Installing Visual C++...';
      Status.Left := 200;
      Status.Top := 200;
      Status.Width := 227;
      Status.Height := 20;
      Exec2(ExpandConstant('{src}\Redist\vcredist_x86.exe'),'/q',false);
    end;
    if Framework.Checked then begin
      Status.Caption:='Installing Framework...';
      Status.Left := 200;
      Status.Top := 200;
      Status.Width := 227;
      Status.Height := 20;
      Exec2(ExpandConstant('{src}\Redist\dotnetfx.exe'),'/q',false);
    end;
  end;
  if (CurStep=ssInstall) and ISDoneError then begin
    Exec2(ExpandConstant('{uninstallexe}'), '/VERYSILENT', false);
  end;
end;
//-------- First Page --------\\
procedure CurPageChanged1(CurPageID: integer);
begin
  if CurPageID=wpWelcome then begin
    HideComponents;    
    WizardForm.Position:=poScreenCenter;
    Bevel3.Hide;
    Bevel4.Hide;
    Bevel5.Hide;
    Bevel6.Hide;
    WizardForm.WizardBitmapImage.Show;
    WelcomeLbl.Show;
    WizardForm.CancelButton.show;
  end;
//-------- Second Page --------\\
  if CurPageID=wpSelectDir then begin
    HideComponents;
    WizardForm.Position:=poScreenCenter;
    WizardForm.WizardSmallBitmapImage.Show;
    WizardForm.Bevel1.Show;
    DirBevel.Show;
    Bevel3.show;
    Bevel4.Show;
    Bevel5.Show;
    Bevel6.Show;
    Bevel7.Show;
    Bevel8.hide;
    Bevel9.Show;
    Bevel11.Show;
    WizardForm.Caption:= 'Choose Game Installation Directory';
    WizardForm.SelectDirBitmapImage.Show;
    WizardForm.SelectGroupBitmapImage.Show;
    WizardForm.DirEdit.Show;
    WizardForm.GroupEdit.Show;
    WizardForm.DirBrowseButton.Show;
    WizardForm.GroupBrowseButton.Show;
    WizardForm.NoIconsCheck.Show;
    DirLbl.Show;
    GroupLbl.Show;
    PartitionSpaceLabel.Show;
    FreeSpaceLabel.Show;
    GameSpaceLabel.Show;
    NeedSpaceLabel.Show;
    GetFreeSpaceCaption(nil);
  end;
//--------  Third page  --------\\
  if CurPageID=wpSelectTasks then begin
    HideComponents;
    WizardForm.Position:=poScreenCenter;
    WizardForm.Caption:= 'Select All Redist';
    WizardForm.WizardSmallBitmapImage.Show;
    WizardForm.Bevel1.Show;
    Bevel3.Hide;
    Bevel4.Hide;
    Bevel5.Hide;
    Bevel6.Hide;
    Bevel20.Show;
    Bevel21.Show;
    Bevel22.Show;
    Bevel23.Show;
    WizardForm.ComponentsList.Show;
    WizardForm.TasksList.Show;
    DirectXCB.Show;
    DirectXCB.Checked:= False;
    DirectXCB.Enabled:= True;
    VisualCCB.Show;
    VisualCCB.Checked:= False;
    VisualCCB.Enabled:= True;
    NvidiaPhysx.Checked:= False;
    NvidiaPhysx.Enabled:= False;
    NvidiaPhysx.Hide;
    Framework.Hide;
    Framework.Enabled:= False;
    Framework.Checked:= False;
    IconCB.Show;
    IconCB.Checked:= True;
    TasksBevel.Hide;
    TasksLbl.Show;
    WizardForm.NextButton.Caption:='Install';
    TasksSeparateBevel.Show;
  end;
//--------Installation Page--------\\
  if CurPageID=wpInstalling then begin
    TasksSeparateBevel.Hide;
    HideComponents;
    WizardForm.Position:=poScreenCenter;
    WizardForm.WizardSmallBitmapImage.Show;
    WizardForm.Caption:= 'Game Installing Process';
    WizardForm.Bevel1.Show;
    WizardForm.TasksList.CheckItem(0,IconCB.Checked);
  end;
//--------Game was successfully installed PAGE--------\\
  if CurPageID=wpFinished then begin
    HideComponents;
    WizardForm.Position:=poScreenCenter;
    WizardForm.WizardBitmapImage.Show;
    WelcomeLbl.Show;
    WelcomeLbl.Left:=145;
    WizardForm.Caption:= 'Game Installed Successfully..!';
    WelcomeLbl.Caption:='{#AppName} Game Installed Successfully On Your PC.' + #13#10#13#10 + 'Run The Game From Shortcut In Start Menu or Desktop Shortcut.' + #13#10#13#10 + 'Click Finish Button To Exit The Installation Setup.';
  end;
//--------Game Fail To Install PAGE--------\\
  if (CurPageID = wpFinished) and ISDoneError then
  begin
    //LabelTime3.Hide;
    WizardForm.Caption:= 'Error! {#AppName} Game';
    WelcomeLbl.Font.Color:= clRed;
    WelcomeLbl.Caption:= 'Setup Encountered an Error while Installing {#AppName} Game' + #13#10#13#10 + 'Changes Were Not Saved , Please Reinstall The Game Setup Again.';
    WelcomeLbl.Left:=163;
  end;
end;

function ShouldSkipPage1(PageID: Integer): Boolean;
begin
  if (PageID=wpSelectProgramGroup) or (PageID=wpReady) or (PageID=wpSelectComponents) then Result:=true;
end;

procedure DeinitializeSetup1();
begin
	ShowWindow(StrToInt(ExpandConstant('{wizardhwnd}')), 0);
	UnloadSkin();
end;

procedure ShowSplashScreen(p1:HWND;p2:AnsiString;p3,p4,p5,p6,p7:integer;p8:boolean;p9:Cardinal;p10 :integer); external 'ShowSplashScreen@files:isgsg.dll stdcall delayload';
procedure InitializeWizard2();
begin
  ExtractTemporaryFile('Splash.png');
  ShowSplashScreen(WizardForm.Handle,ExpandConstant('{tmp}\Splash.png'),1000,3000,1000,0,255,True,$FFFFFF,10);
end;

function InitializeSetup(): Boolean;
begin
  Result := InitializeSetup1(); if not Result then exit;
end;

procedure InitializeWizard();
begin
  ExtractTemporaryFile('music.mp3');
  if BASS_Init(-1, 44100, 0, 0, 0) then
  begin
    SoundStream := BASS_StreamCreateFile(False,
    ExpandConstant('{tmp}\music.mp3'), 0, 0, 0, 0,
    EncodingFlag or BASS_SAMPLE_LOOP);
    BASS_SetConfig(BASS_CONFIG_GVOL_STREAM, 2500);
    BASS_ChannelPlay(SoundStream, False);

    SoundCtrlButton := TNewButton.Create(WizardForm);
    SoundCtrlButton.Parent := WizardForm;
    SoundCtrlButton.SetBounds(210,347,100,30);
    SoundCtrlButton.Caption :=
    ExpandConstant('{cm:SoundCtrlButtonCaptionSoundOff}');
    SoundCtrlButton.OnClick := @SoundCtrlButtonClick;
  RedesignWizardForm;
  InitializeWizard1();
  InitializeWizard2();
end;
end;

procedure CurStepChanged(CurStep: TSetupStep);
begin
  CurStepChanged1(CurStep);
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  CurPageChanged1(CurPageID);
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := ShouldSkipPage1(PageID); if not Result then exit;
end;

procedure DeinitializeSetup();
begin

  BASS_Free();
  DeinitializeSetup1();
end;


