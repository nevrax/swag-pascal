(*
  Category: SWAG Title: Borland DELPHI
  Original name: 0227.PAS
  Description: Registry - Add/Change Setting
  Author: SWAG SUPPORT TEAM
  Date: 03-04-97  13:18
*)


function RegGetStr( sKey, sItem, sDefVal : string ) : string;
var
  reg : TRegIniFile;
begin
  reg := TRegIniFile.Create( sKey );
  Result := reg.ReadString( '', sItem, sDefVal );
  reg.Free;
end;

procedure RegSetStr( sKey, sItem, sVal : string );
var
  reg : TRegIniFile;
begin
  reg := TRegIniFile.Create( sKey );
  reg.WriteString( '', sItem, sVal + #0 );
  reg.Free;
end;

// now, you can call above helper functions like you wanted:
//

{ATextBox.Text :=3D RegGetStr( 'Software\MyCompanyName\MyProductName',
'variable1', 'default value goes here' );

RegSetStr( 'Software\MyCompanyName\MyProductName', 'variable1',
ATextBox.Text );}


