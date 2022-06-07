$MethodDefinition = @'
[DllImport("kernel32.dll", CharSet = CharSet.Unicode)]
public static extern bool CopyFile(string lpExistingFileName, string lpNewFileName, bool bFailIfExists);
'@
$Kernel32 = Add-Type -MemberDefinition $MethodDefinition -Name 'Kernel32' -Namespace 'Win32' -PassThru
$Kernel32::CopyFile("$($Env:SystemRoot)\System32\calc.exe", "$($Env:USERPROFILE)\Desktop\calc.exe", $False)
