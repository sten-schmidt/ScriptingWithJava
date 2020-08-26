set -e
set -o pipefail
#set -x

#Default-Values
PROG="App"
MODE="DIR"
COMPILE=0   

init() {
    PACKAGE=$(grep -i "PACKAGE " $PROG.java | cut -d' ' -f2 | sed 's/;//g')
    PACKAGEPATH=$(echo "$PACKAGE" | sed -r 's/[.]/\//g')
}

compile() {
    if [ -x "$(command -v javac)" ]; then
        if [ "$MODE" = "DIR" ] && [ "$PROG.java" -nt "$PROG/$PACKAGEPATH/$PROG.class" ]; then
            COMPILE=1
        fi
        
        if [ "$MODE" = "JAR" ] && [ "$PROG.java" -nt "$PROG.jar" ]; then
            COMPILE=1
        fi
    fi

    if [ $COMPILE -eq 1 ]; then
        echo "compiling..."
        mkdir -p "./$PROG"
        javac -d "./$PROG" *.java
        
        if [ "$MODE" = "JAR" ]; then
            echo "Createing JAR-File"
            cd "./$PROG"
            echo "Manifest-Version: 1.0" > "$PACKAGEPATH/$PROG.mf"
            echo "Main-Class: $PACKAGE.$PROG" >> "$PACKAGEPATH/$PROG.mf"
            jar cmf "$PACKAGEPATH/$PROG.mf" "../$PROG.jar" $PACKAGEPATH/*.class ../$PROG.java 
            cd ..
            rm -fr "./$PROG/"
        fi
    fi    
}

execute() {
    if [ "$MODE" = "JAR" ]; then
        echo "executing jar..."
        java -jar "$PROG.jar" "$*"
    fi

    if [ "$MODE" = "DIR" ]; then
        echo "executing class..."
        java -cp "./$PROG" "$PACKAGE.$PROG" "$*"
    fi
}

start() {
	init
	compile
	execute "$*"
}