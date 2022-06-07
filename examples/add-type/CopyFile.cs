[DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
public static extern bool CopyFile(
    string lpExistingFileName,
    string lpNewFileName,
    bool   bFailIfExists
);
