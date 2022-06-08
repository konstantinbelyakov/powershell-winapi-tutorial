# Three Ways to Call a Windows API Method

Windows API functions are very handy for low level tasks, when the close interaction with the operating system is required. There are three ways to access Windows API from PowerShell:

1. [Use the Add-Type Cmdlet that Calls the Windows API Function](add-type.md)
2. [Get a Private .NET Method that Calls the Windows API Function](private-method.md)
3. [Call the Windows API Function from a Dynamically Defined Method](reflection.md)

In most cases, the first way is sufficient, as it is rather simple and straightforward. However, `Add-Type` calls the C# compiler (_css.exe_) and writes temporary files to disk, which may be inappropriate in certain scenarios. Try other two methods if you want to minimize your script footprint on a target system.

Most of Windows API functions already have wrappers in .NET APIs, although these wrapper methods may be private. The second way implies finding and accessing an appropriate method.

The third option is to use reflection and dynamically generate the code that will call a Windows API function. This approach is handy when the required Windows API function wrapper not present in .NET assemblies loaded by the current PowerShell session, and you also do not want to write temporary files.

The table below may help you to choose an appropriate way.

|                                       | Add-Type Cmdlet | Private .NET Method | Dynamically Defined Method |
|---------------------------------------|:---------------:|:-------------------:|:--------------------------:|
| **Difficulty**                        | Simple          | Medium              | Complex                    |
| **Temporary files**                   | Yes             | No                  | No                         |
| **Requires an existing .NET wrapper** | No              | Yes                 | No                         |
