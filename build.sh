ndk_root=$(pwd)/android-ndk-r14b
rm -rf ./build
mkdir ./build
cd ./build

echo $ndk_root
cmake .. \
    -G"Unix Makefiles" \
    -DANDROID_STL=c++_shared \
    -DANDROID_LD=lld \
    -D__ANDROID_API__=21 \
    -DANDROID_ABI=armeabi-v7a \
    -DCMAKE_TOOLCHAIN_FILE=${ndk_root}/build/cmake/android.toolchain.cmake