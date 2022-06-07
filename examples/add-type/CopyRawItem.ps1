Import-Module ./CopyRawItem.psm1
Copy-RawItem -Path "$($Env:SystemRoot)\System32\calc.exe" -Destination "$($Env:USERPROFILE)\Desktop\calc.exe" -FailIfExists
