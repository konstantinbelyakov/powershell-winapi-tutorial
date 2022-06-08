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
    $DynAssembly = New-Object System.Reflection.AssemblyName('Win32Lib')
    $AssemblyBuilder = [AppDomain]::CurrentDomain.DefineDynamicAssembly(
        $DynAssembly, [Reflection.Emit.AssemblyBuilderAccess]::Run)
    $ModuleBuilder = $AssemblyBuilder.DefineDynamicModule('Win32Lib', $False)
    $TypeBuilder = $ModuleBuilder.DefineType('Kernel32', 'Public, Class')
    $PInvokeMethod = $TypeBuilder.DefineMethod('CopyFile', [Reflection.MethodAttributes] 'Public, Static',
        [Bool], [Type[]] @([String], [String], [Bool]))
    $DllImportConstructor = [Runtime.InteropServices.DllImportAttribute].GetConstructor(@([String]))
    $FieldArray = [Reflection.FieldInfo[]] @(
        [Runtime.InteropServices.DllImportAttribute].GetField('EntryPoint'),
        [Runtime.InteropServices.DllImportAttribute].GetField('PreserveSig'),
        [Runtime.InteropServices.DllImportAttribute].GetField('SetLastError'),
        [Runtime.InteropServices.DllImportAttribute].GetField('CallingConvention'),
        [Runtime.InteropServices.DllImportAttribute].GetField('CharSet')
    )
    $FieldValueArray = [Object[]] @(
        'CopyFile',
        $True,
        $True,
        [Runtime.InteropServices.CallingConvention]::Winapi,
        [Runtime.InteropServices.CharSet]::Unicode
    )
    $SetLastErrorCustomAttribute = New-Object Reflection.Emit.CustomAttributeBuilder(
        $DllImportConstructor, @('kernel32.dll'), $FieldArray, $FieldValueArray)
    $PInvokeMethod.SetCustomAttribute($SetLastErrorCustomAttribute)
    $Kernel32 = $TypeBuilder.CreateType()
    $CopyResult = $Kernel32::CopyFile($Path, $Destination, ([Bool] $PSBoundParameters['FailIfExists']))
    if ($CopyResult -eq $False) {
        throw New-Object ComponentModel.Win32Exception(
            [System.Runtime.InteropServices.Marshal]::GetLastWin32Error())
    }
    else {
        Write-Output (Get-ChildItem $Destination)
    }
}
