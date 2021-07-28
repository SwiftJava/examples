
### SwiftJava examples

Git submodule containing AWT and Swing examples intended to be cloned
separately to build on Linux or macOS using the following commands:

```Shell
    git clone https://github.com/SwiftJava/examples.git
    cd examples

    export JVM_LIBRARY_PATH=$JAVA_HOME/jre/lib/server # macOS
    export JVM_LIBRARY_PATH=$JAVA_HOME/jre/lib/amd64/server # Linux

    ulimit -n 10000 # increase file descriptors for link on Linux

    # or, to use the JVM that comes with Xcode

    export JAVA_HOME=/Applications/Xcode.app/Contents/SharedFrameworks/ContentDeliveryServices.framework/Versions/A/itms/java
    export JVM_LIBRARY_PATH=$JAVA_HOME/lib/server # even works on an M1
    
    swift build -Xlinker -L$JVM_LIBRARY_PATH -Xlinker -rpath -Xlinker $JVM_LIBRARY_PATH -Xlinker -ljvm
```
