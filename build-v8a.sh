ndk_dir=$(pwd)/android-ndk-r14b
rm -rf ./build
mkdir ./build
cd ./build
compiler=$ndk_dir/toolchains/aarch64-linux-android-4.9/prebuilt/linux-x86_64/bin
sysroot=$ndk_dir/sysroot
platform=$ndk_dir/platforms/android-21/arch-arm64/
export PATH=$PATH:$compiler:$sysroot:$platform

cmake ..    -DCMAKE_TOOLCHAIN_FILE=../XCompile-Android.txt \
            -DANDROID_ABI="arm64-v8a" \
            -DHOST=aarch64-linux-android \
            -DBUILD_SHARED_LIBS=OFF \
            -DCMAKE_INSTALL_PREFIX=$(pwd)/android/arm64-v8a \
            -DCMAKE_SYSROOT=$platform \
            -DANDROID_NDK=$ndk_dir \
            -DCMAKE_BUILD_TYPE=Release \
            -DANDROID_PLATFORM=android-21 \

sudo make install
tar -cvf lib.zip ./libopenal.so  ./libopenal.so.1 ./libopenal.so.1.19.1
gzip lib.zip
echo "if you use vscode, please download lib.zip"
