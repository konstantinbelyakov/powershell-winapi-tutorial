function Copy-RawItem {
    [CmdletBinding()]
    [OutputType([System.IO.FileSystemInfo])]
    Param (
        [Parameter(Mandatory = $True, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Path,
        [Parameter(Mandatory = $True, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [String]
        $Destination,
        [Switch]
        $FailIfExists
    )
    $MethodDefinition = Get-Content -Path .\CopyFile.cs
    $Kernel32 = Add-Type -MemberDefinition $MethodDefinition -Name 'Kernel32' -Namespace 'Win32' -PassThru
    $CopyResult = $Kernel32::CopyFile($Path, $Destination, ([Bool] $PSBoundParameters['FailIfExists']))
    if ($CopyResult -eq $False) {
        throw New-Object ComponentModel.Win32Exception(
            [System.Runtime.InteropServices.Marshal]::GetLastWin32Error())
    }
    else {
        Write-Output (Get-ChildItem $Destination)
    }
}
