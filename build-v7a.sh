ndk_dir=$(pwd)/android-ndk-r14b
abi="armeabi-v7a"
prefix=$(pwd)/android/$abi
rm -rf ./build
mkdir ./build
cd ./build
compiler=$ndk_dir/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
sysroot=$ndk_dir/sysroot
platform=$ndk_dir/platforms/android-21/arch-arm/
export PATH=$PATH:$compiler:$sysroot:$platform

cmake ..    -DCMAKE_TOOLCHAIN_FILE=../XCompile-Android.txt \
            -DANDROID_ABI=$abi \
            -DHOST=arm-linux-androideabi \
            -DBUILD_SHARED_LIBS=OFF \
            -DCMAKE_INSTALL_PREFIX=$prefix \
            -DCMAKE_SYSROOT=$platform \
            -DANDROID_NDK=$ndk_dir \
            -DCMAKE_BUILD_TYPE=Release \
            -DANDROID_PLATFORM=android-21 \
            -DCMAKE_SHARED_LINKER_FLAGS="-Wl,-z,nodlopen" \

make install
tar -cvf lib.zip ./libopenal.so # ./libopenal.so.1 ./libopenal.so.1.19.1
gzip lib.zip
echo "if you use vscode, please download lib.zip"
