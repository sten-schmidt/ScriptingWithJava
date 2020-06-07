[String]$PROG="MyApp"
[String]$MODE="DIR"
[bool]$COMPILE=$false

[String]$PACKAGE=(Select-String -Pattern 'package ' -SimpleMatch -Path "./$PROG.java").Line.replace("package ","").Replace(";","").Trim()
[String]$PACKAGEPATH=$PACKAGE.Replace(".","/")

if($MODE -eq "DIR") {
    $COMPILE=(-Not [IO.File]::Exists("$PROG/$PACKAGEPATH/$PROG.class"))
    if(-Not $COMPILE) {
        $COMPILE=((Get-Item -Path "$PROG.java").LastWriteTime -gt (Get-Item -Path "$PROG/$PACKAGEPATH/$PROG.class").LastWriteTime)
    }
}

if ($MODE -eq "JAR") {
    $COMPILE=(-Not [IO.File]::Exists("$PROG.jar"))
    if(-Not $COMPILE) {
        $COMPILE=((Get-Item -Path "$PROG.java").LastWriteTime -gt (Get-Item -Path "$PROG.jar").LastWriteTime)
    }
}

if($COMPILE) {
    Write-Output "compiling..."
    New-Item -Path "./$PROG" -ItemType Directory -Force | Out-Null
    Invoke-Expression "javac -d `"./$PROG`" *.java"
    
    if($MODE -eq "JAR") {
        Write-Output "Creating JAR-File"
        Set-Location "./$PROG"
        [String]$manifestContent="Manifest-Version: 1.0" 
        $manifestContent += [Environment]::NewLine
        $manifestContent += "Main-Class: $PACKAGE.$PROG"
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [IO.File]::WriteAllLines("$PROG/$PACKAGEPATH/$PROG.mf", $manifestContent, $Utf8NoBomEncoding)
        Invoke-Expression "jar cmf `"$PACKAGEPATH/$PROG.mf`" `"../$PROG.jar`" $PACKAGEPATH/*.class ../$PROG.java"
        Set-Location ..
        Remove-Item -Force -Recurse "./$PROG/"
    }
}

if($MODE -eq "JAR") {
    Write-Output "executing jar..."
    Invoke-Expression "java -jar `"$PROG.jar`""
}

if($MODE -eq "DIR") {
    Write-Output "executing class..."
    Invoke-Expression "java -cp `"./$PROG`" `"$PACKAGE.$PROG`""
}