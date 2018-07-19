; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "QModManager (Subnautica)"
#define MyAppVersion "1.3"
#define MyAppPublisher "Qwiso, RandyKnapp & AlexejheroYTB"
#define MyAppURL "https://github.com/Qwiso/QModManager"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{52CC87AA-645D-40FB-8411-510142191678}
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
OutputBaseFilename=QModsSetup
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
ExitSetupMessage=Setup is not complete. If you exit now, {#MyAppName} will not be installed.%n%nExit Setup?
SelectDirLabel3=Please select your Subnautica install folder.
SelectDirBrowseLabel=If this is correct, click Next. If you need to select a different Subnautica install folder, click Browse.
WizardSelectDir=Select Subnautica Install Location

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "Result\0Harmony.dll"; DestDir: "{app}\Subnautica_Data\Managed"; Flags: ignoreversion
Source: "Result\Mono.Cecil.dll"; DestDir: "{app}\Subnautica_Data\Managed"; Flags: ignoreversion
Source: "Result\Newtonsoft.Json.dll"; DestDir: "{app}\Subnautica_Data\Managed"; Flags: ignoreversion
Source: "Result\QModInstaller.dll"; DestDir: "{app}\Subnautica_Data\Managed"; Flags: ignoreversion
Source: "Result\QModManager.exe"; DestDir: "{app}\Subnautica_Data\Managed"; Flags: ignoreversion

[Run]
Filename: "{app}\Subnautica_Data\Managed\QModManager.exe"; Parameters: "-i"

[UninstallRun]
Filename: "{app}\Subnautica_Data\Managed\QModManager.exe"; Parameters: "-u"

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

	if FileExists(steamInstallPath + '\steamapps\common\Subnautica\Subnautica.exe') then
	begin
		Result := steamInstallPath + '\steamapps\common\Subnautica';
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
						if FileExists(steamInstallPath + '\steamapps\common\Subnautica\Subnautica.exe') then
						begin
							Result := steamInstallPath + '\steamapps\common\Subnautica';
							Exit;
						end;
					end;
				end;
			end;
		end;
	end;
	
	Result := 'Remove this';
end;
