
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

The MIT License (MIT)
Copyright (c) 2016, John Holdsworth

Permission is hereby granted, free of charge, to any person obtaining a copy of this
software and associated documentation files (the "Software"), to deal in the Software
without restriction, including without limitation the rights to use, copy, modify, merge,
publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons
to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
