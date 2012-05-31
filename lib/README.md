# lib.scpt

***Framework to ease the development of AppleScript scripts.***

## Examples

*(Assuming lib.scpt is in ~/Library/Scripts/lib)*

**Basic Usage:**

```applescript
property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"
set front_app to frontmostApplication() of _UI of lib
display alert (name of front_app as string)
```

**Including an application library:**

```applescript
property lib : load script POSIX path of (path to scripts folder) & "lib/lib.scpt"
property Firefox : include("Application/Firefox") of lib
tell Firefox to refresh()
```
