
### SwiftJava examples

Git submodule containing AWT and Swing examples intended to be cloned
separately to build on Linux or macOS using the following commands:

```Shell
    git clone https://github.com/SwiftJava/examples.git
    cd examples

    export JVM_LIBRARY_PATH=$JAVA_HOME/jre/lib/server # macOS
    export JVM_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server # Linux

    ulimit -n 10000 # increase file descriptors for link
    
    swift build -Xlinker -L$JVM_LIBRARY_PATH -Xlinker -rpath -Xlinker $JVM_LIBRARY_PATH -Xlinker -ljvm
```
