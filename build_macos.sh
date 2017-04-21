#!/bin/bash
#
# Experimental build using static libraries to get binary size down
#

export CONFIG=${1:-debug}
export XCODE_DEVELOPER=`xcode-select -p`
export JVM_LIBRARY_PATH=$JAVA_HOME/jre/lib/server

time swift build -c $CONFIG -Xlinker -L$JVM_LIBRARY_PATH -Xlinker -rpath -Xlinker $JVM_LIBRARY_PATH -Xlinker -ljvm &&

ls .build/$CONFIG/*.build/*.o >/tmp/$CONFIG.txt &&

"$XCODE_DEVELOPER"/Toolchains/XcodeDefault.xctoolchain/usr/bin/libtool -static -arch_only x86_64 -syslibroot "$XCODE_DEVELOPER"/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk -filelist /tmp/$CONFIG.txt -o lib$CONFIG.a &&

"$XCODE_DEVELOPER"/Toolchains/XcodeDefault.xctoolchain/usr/bin/ld lib$CONFIG.a "$XCODE_DEVELOPER"/Toolchains/XcodeDefault.xctoolchain/usr/lib/arc/libarclite_macosx.a -framework CoreFoundation -L$JVM_LIBRARY_PATH -rpath $JVM_LIBRARY_PATH -L .build/$CONFIG -F "$XCODE_DEVELOPER"/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks -syslibroot "$XCODE_DEVELOPER"/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk -lSystem -arch x86_64 -L"$XCODE_DEVELOPER"/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx -rpath "$XCODE_DEVELOPER"/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx -macosx_version_min 10.10.0 -no_objc_category_merging -o ./$CONFIG.bin -ljvm
