# Использование командлета Add-Type для вызова функции Win32 API

Командлет [Add-Type](https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.utility/add-type) добавляет заданный .NET класс в текущий сеанс PowerShell. Данная статья демонстрирует использование этого командлета для доступа к функции [CopyFile](https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-copyfile), объявленной в библиотеке  _kernel32.dll_.

## Базовая реализация

Рассмотрим скрипт вызывающий функцию `CopyFile`:

```ps1 title="PowerShell"
--8<-- "examples/add-type/CopyItemSimple.ps1"
```

Этот скрипт делает следующее:

* Переменная `$MethodDefinition` содержит определение метода на C#, соответствующее сигнатуре `CopyFile` на C++:

    ```cpp  title="C++"
    BOOL CopyFile(
        [in] LPCTSTR lpExistingFileName,
        [in] LPCTSTR lpNewFileName,
        [in] BOOL    bFailIfExists
    );
    ```
    ```cs title="C#"
    --8<-- "examples/add-type/CopyFile.cs"
    ```

    Обратите внимание на корректность соответствия типов параметров в С++ и в .NET коде:

    | Тип C/C++  | Тип .NET  |
    |------------|-----------|
    | BOOL       | bool      |
    | LPCTSTR    | string    |

* Командлет `Add-Type` создает класс `Kernel32` содержащий метод `CopyItem`, определение которого задано на предыдущем шаге.

* Последняя строка кода вызывает метод `Kernel32::CopyFile` для копирования файла _calc.exe_ из папки _Windows\System32_ на рабочий стол.

## Дальнейшие улучшения

* Редактирование C# кода в строковой константе внутри PowerShell скрипта может оказаться неудобным. Вы можете сохранить C# код в отдельный файл и получить контент файла с помощью командлета [Get-Content](https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.management/get-content).
* Вы можете объявить командлет `Copy-RawItem` в [своем PowerShell модуле](https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-script-module) --- чтобы облегчить повторное использование кода.
* Вы можете реализовать обработку ошибок --- генерировать исключение при неудачном завершении `CopyFile`.

Следующий ниже код демонстрирует реализацию модуля _CopyRawItem.psm1_:

```psm1 title="Модуль PowerShell"
--8<-- "examples/add-type/CopyRawItem.psm1"
```

Вы можете импортировать этот модуль и вызывать `Copy-RawItem` из вашего скрипта таким образом:

```ps1 title="PowerShell"
--8<-- "examples/add-type/CopyRawItem.ps1"
```

В этом примере, файл базы данных диспетчера учётных записей безопасности копируется из [теневой копии тома](https://docs.microsoft.com/ru-ru/windows/win32/vss/volume-shadow-copy-service-portal) во временную папку (что невозможно при использовании стандартного командлета [Copy-Item](https://docs.microsoft.com/ru-ru/powershell/module/microsoft.powershell.management/copy-item)). Если запустить `Copy-RawItem` дважды, вы получите ошибку "The file exists":

![Copy-RawItem result](../images/copy-rawitem-result.png)

!!! Tip "Совет"
    Если вы получаете ошибку "Access is denied" при доступе к теневой копии, перезапустите сеанс PowerShell от имени администратора.

!!! Note "Примечание"
    Использованный здесь код доступен на GitHub: [powershell-winapi-tutorial/examples/add-type](https://github.com/konstantinbelyakov/powershell-winapi-tutorial/tree/main/examples/add-type).
