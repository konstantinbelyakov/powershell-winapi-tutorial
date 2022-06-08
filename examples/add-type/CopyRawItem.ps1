Import-Module ./CopyRawItem.psm1
Copy-RawItem \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1\Windows\System32\config\SAM C:\temp\SAM -FailIfExists
