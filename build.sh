ndk_root=$(pwd)/android-ndk-r14b
rm -rf ./build
mkdir ./build
cd ./build

echo $ndk_root
cmake .. -DANDROID_STL=c++_shared -DANDROID_LD=lld \
    -DCMAKE_TOOLCHAIN_FILE=${ndk_root}/build/cmake/android.toolchain.cmake