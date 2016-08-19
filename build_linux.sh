#!/bin/bash
#
# Experimental build using static libraries to get binary size down
#

export CONFIG=${1:-debug}
export SWIFT_HOME=~/swift-3.0-PREVIEW-6-ubuntu15.10
export JVM_LIBRARY_PATH=$JAVA_HOME/lib/amd64/server

time $SWIFT_HOME/usr/bin/swift build -c $CONFIG -Xlinker -L$JVM_LIBRARY_PATH -Xlinker -rpath -Xlinker $JVM_LIBRARY_PATH -ljvm &&

ar cr lib$CONFIG.a .build/$CONFIG/*.build/*.o &&
ranlib lib$CONFIG.a &&

/usr/bin/clang++ -fuse-ld=gold -target x86_64-unknown-linux-gnu -Xlinker -rpath -Xlinker $SWIFT_HOME/usr/lib/swift/linux $SWIFT_HOME/usr/lib/swift/linux/x86_64/swift_begin.o  -L. -l$CONFIG -Xlinker -L$JVM_LIBRARY_PATH -Xlinker -rpath -Xlinker $JVM_LIBRARY_PATH -ljvm -Xlinker "-rpath=\$ORIGIN" -L .build/$CONFIG -L $SWIFT_HOME/usr/lib/swift/linux --target=x86_64-unknown-linux-gnu -lswiftCore -lswiftGlibc -lswiftSwiftOnoneSupport -lFoundation $SWIFT_HOME/usr/lib/swift/linux/x86_64/swift_end.o -o ./$CONFIG.bin
