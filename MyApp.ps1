#/bin/env pwsh

# Load ScriptingWithJava functions and variables
. "$PSScriptRoot\ScriptingWithJava.ps1"

# Customize configuration variables
$PROG="MyApp"	# Name of you public Java class, Filename must match $PROG.java 
$MODE="JAR"		# JAR: a Jar-File ($PROG.jar) is created, DIR: Class-Files are created in a Subdirectory (./$PROG/...)
$COMPILE=0 		# 0: Compile when necessary, 1: Compile on every run


# Start your Java application 
Start-App -commandlineArgs $args