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
    $mscorlib = [AppDomain]::CurrentDomain.GetAssemblies() | Where-Object {$_.Location -and ($_.Location.Split('\')[-1] -eq 'mscorlib.dll')}
    $Win32Native = $mscorlib.GetType('Microsoft.Win32.Win32Native')
    $CopyFileMethod = $Win32Native.GetMethod('CopyFile', ([Reflection.BindingFlags] 'NonPublic, Static'))
    $CopyResult = $CopyFileMethod.Invoke($null, @($Path, $Destination, ([Bool] $PSBoundParameters['FailIfExists'])))
    $HResult = [System.Runtime.InteropServices.Marshal]::GetLastWin32Error()
    if ($CopyResult -eq $False -and $HResult -ne 0) {
        throw New-Object ComponentModel.Win32Exception($HResult)
    }
    else {
        Write-Output(Get-ChildItem $Destination)
    }
}
