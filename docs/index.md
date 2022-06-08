# Introduction

!!! Tip

    The content is available in English and Russian. You can use the language switch in the top toolbar of this website (to the left from the search box) to change language.

This documentation project is based on the blog post series by Matt Graeber:

* [Use PowerShell to Interact with the Windows API: Part 1](https://devblogs.microsoft.com/scripting/use-powershell-to-interact-with-the-windows-api-part-1/)
* [Use PowerShell to Interact with the Windows API: Part 2](https://devblogs.microsoft.com/scripting/use-powershell-to-interact-with-the-windows-api-part-2/)
* [Use PowerShell to Interact with the Windows API: Part 3](https://devblogs.microsoft.com/scripting/use-powershell-to-interact-with-the-windows-api-part-3/)

Here you can find tutorials and examples on how to access the [Windows API](https://docs.microsoft.com/en-us/windows/win32/apiindex/windows-api-list) (formerly called the Win32 API) from [PowerShell](https://docs.microsoft.com/en-us/powershell/) scripts. Tutorials consider three alternative ways of calling the [CopyFile](https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-copyfile) function, and demonstrate the creation of a PowerShell module with the `Copy-RawItem` cmdlet. The custom cmdlet differs from the standard [Copy-Item](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/copy-item), as it can handle special device object paths, such as paths to files backed up by the [Volume Shadow Copy Service](https://docs.microsoft.com/en-us/windows/win32/vss/volume-shadow-copy-service-portal):

`\\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy1_`

Handling of errors thrown by the called Windows API method is also demonstrated.

![Copy-RawItem result](images/copy-rawitem-result.png)

!!! Tip

    Accessing `CopyFile` is considered as a simple basic example here. You can use a similar approach to access other Windows APIs

## Contents

* [Three Ways to Call a Windows API Method](win32-approaches/index.md)
    * [Use the Add-Type Cmdlet that Calls the Windows API Function](win32-approaches/add-type.md)
    * [Get a Private .NET Method that Calls the Windows API Function](win32-approaches/private-method.md)
    * [Call the Windows API Function from a Dynamically Defined Method](win32-approaches/reflection.md)
* [Summary](summary.md)

!!! note

    Several sections are not completed yet, the content is under development.

## Code Examples

Examples demonstrated in this documentation are available an GitHub: [powershell-winapi-tutorial/examples/](https://github.com/konstantinbelyakov/powershell-winapi-tutorial/tree/main/examples/).