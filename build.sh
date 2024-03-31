#!/bin/bash
set -o errexit -o nounset -o pipefail

# Delete the previous build result.
rm -rf ./prebuild
rm -rf ./libpng

# Set up ndk path.
export NDK=/path/to/ndk

# Only choose one of these:
# for linux
#export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
# for windows
#export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/windows-x86_64
# for mac
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64


# Check out libpng.
# Set this to libpng version. 
git clone https://github.com/glennrp/libpng -b v1.6.43

# Set this to your minSdkVersion.
export API=21

cd libpng

# List of target architectures
targets=("aarch64-linux-android" "armv7a-linux-androideabi" "i686-linux-android" "x86_64-linux-android")
# List of abis for create folders
abis=("arm64-v8a" "armeabi-v7a" "x86" "x86_64")

export AR=$TOOLCHAIN/bin/llvm-ar
export LD=$TOOLCHAIN/bin/ld
export RANLIB=$TOOLCHAIN/bin/llvm-ranlib
export STRIP=$TOOLCHAIN/bin/llvm-strip

targets_length=${#targets[@]}
for (( i=0; i<targets_length; i++ )); do
    target=${targets[i]}
    abi=${abis[i]}
    echo "Building for {$target}({$abi})..."
    export CC=$TOOLCHAIN/bin/$target$API-clang
    export CXX=$TOOLCHAIN/bin/$target$API-clang++
    export AS=$CC

    ./configure --host=$target  --with-pic
    make clean
    make
    
    mkdir -p ../prebuild/$abi
    mv .libs/*.a ../prebuild/$abi/libpng.a
done
