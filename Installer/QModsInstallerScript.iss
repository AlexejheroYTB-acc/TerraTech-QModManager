; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "QModManager (TerraTech)"
#define MyAppVersion "1.2.1"
#define MyAppPublisher "AlexejheroYTB"
#define MyAppURL "https://github.com/AlexejheroYTB/TerraTech-QModManager"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{53D64B81-BFF9-47E3-A599-66C18ED14B71}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={code:GetDefaultDir}
DefaultGroupName={#MyAppName}
DisableProgramGroupPage=yes
OutputDir=.
OutputBaseFilename=TerraTechQMMSetup
SetupIconFile=QModsIcon.ico
Compression=lzma
SolidCompression=yes
WizardImageFile=WizardImage.bmp
WizardSmallImageFile=WizardSmallImage.bmp
DisableWelcomePage=no
DisableDirPage=no
DirExistsWarning=no
UsePreviousAppDir=yes

[Messages]
ExitSetupMessage=Setup is not complete. If you exit now, QModManager will not be installed.%nExit Setup?
SelectDirLabel3=Please select your TerraTech install folder.
SelectDirBrowseLabel=If this is correct, click Next. If you need to select a different TerraTech install folder, click Browse.
WizardSelectDir=Select TerraTech Install Location

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "0Harmony.dll"; DestDir: "{app}\TerraTechWin64_Data\Managed"; Flags: ignoreversion
Source: "Mono.Cecil.dll"; DestDir: "{app}\TerraTechWin64_Data\Managed"; Flags: ignoreversion
Source: "QModInstaller.dll"; DestDir: "{app}\TerraTechWin64_Data\Managed"; Flags: ignoreversion
Source: "QModManager.exe"; DestDir: "{app}\TerraTechWin64_Data\Managed"; Flags: ignoreversion

[Run]
Filename: "{app}\TerraTechWin64_Data\Managed\QModManager.exe"; Parameters: "-i"

[UninstallRun]
Filename: "{app}\TerraTechWin64_Data\Managed\QModManager.exe"; Parameters: "-u"

[Code]
function GetDefaultDir(def: string): string;
var
I : Integer;
P : Integer;
steamInstallPath : string;
configFile : string;
fileLines: TArrayOfString;
begin
	steamInstallPath := 'not found';
	if RegQueryStringValue( HKEY_LOCAL_MACHINE, 'SOFTWARE\WOW6432Node\Valve\Steam', 'InstallPath', steamInstallPath ) then
	begin
	end;

	if FileExists(steamInstallPath + '\steamapps\common\TerraTech\TerraTechWin64.exe') then
	begin
		Result := steamInstallPath + '\steamapps\common\TerraTech';
		Exit;
	end
	else
	begin
		configFile := steamInstallPath + '\config\config.vdf';
		if FileExists(configFile) then
		begin
			if LoadStringsFromFile(configFile, FileLines) then
			begin
				for I := 0 to GetArrayLength(FileLines) - 1 do
				begin
					P := Pos('BaseInstallFolder_', FileLines[I]);
					if P > 0 then
					begin
						steamInstallPath := Copy(FileLines[I], P + 23, Length(FileLines[i]) - P - 23);
						if FileExists(steamInstallPath + '\steamapps\common\TerraTech\TerraTechWin64.exe') then
						begin
							Result := steamInstallPath + '\steamapps\common\TerraTech';
							Exit;
						end;
					end;
				end;
			end;
		end;
	end;
  Result := 'Remove this';
end;