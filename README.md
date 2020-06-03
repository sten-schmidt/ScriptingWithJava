# ScriptingWithJava.sh

ScriptingWithJava is a shellscript helping you to make Java usable as a scripting language. 

## Goal

Typical production servers do not provide tools like maven or gradle meanwhile OpenJDK is available. So edit and recompile Java programs in SSH-Sessions is possible but unhandy.

## Requirements

- You are willing to deploy you Java application in source form as .java files.
- All your java files exits in a flat folder.
- All classes are member of the same package. 
- Only one class can be declared public.
- The App-Name defined as $PROG must match the Name of the public class.
- The public class must contain the public static void main method. 

## Functional principle

When this script is called, it compares the change date of the Java program with the compiled jar (or class) file and decides if a recompile/rebuild is necessary before execution.

## TODO

- Support for additional jar files (dependencies)
- Support for non existing Package-Name (default package)

