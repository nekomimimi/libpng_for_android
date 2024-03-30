# libpng_for_android
This bash script builds "libpng" as static libraries for android.
[(libpng official website)](http://www.libpng.org/pub/png/libpng.html)<br>
This script makes "libpng.a" compatible with Android architectures, including arm64-v8a, armeabi-v7a, x86, and x86_64. 

## How to build
### 1.Set the following to the version of libpng for compile.
```bash.sh
git clone https://github.com/glennrp/libpng -b v1.6.43
```

### 2. Set the following to NDK toolchains path.

For example:

```bash.sh
export NDK=/Users/your_id/Library/Android/sdk/ndk/26.2.11394342
```

### 3.Only select the one toolchain about your PC.
#### For Linux:
```bash.sh
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/linux-x86_64
```

#### For Windows:
```bash.sh
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/windows-x86_64
```

#### For MacOS:
```bash.sh
export TOOLCHAIN=$NDK/toolchains/llvm/prebuilt/darwin-x86_64
```

### 4.Set the following to your minSdkVersion.
```bash.sh
export API=21
```

### 5.build.
```bash.sh
./build
```
