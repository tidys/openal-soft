ndk_dir=$(pwd)/android-ndk-r14b
rm -rf ./build
mkdir ./build
cd ./build
compiler=$ndk_dir/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
sysroot=$ndk_dir/sysroot
platform=$ndk_dir/platforms/android-21/arch-arm/
export PATH=$PATH:$compiler:$sysroot:$platform
# echo $PATH

# 这个编译出来的还是linux类型的so，带软链接，Android无法使用
# cmake ..    -DCMAKE_TOOLCHAIN_FILE=../XCompile-Android.txt \
#             -DHOST=arm-linux-androideabi \
#             -DCMAKE_BUILD_TYPE=Release

cmake ..    -DCMAKE_TOOLCHAIN_FILE=../XCompile-Android.txt \
            -DANDROID_ABI="armeabi-v7a" \
            -DHOST=arm-linux-androideabi \
            -DCMAKE_SYSROOT=$platform \
            -DANDROID_NDK=$ndk_dir \
            -DCMAKE_BUILD_TYPE=Release \
            -DANDROID_PLATFORM=android-21 \

make
tar -cvf lib.zip ./libopenal.so # ./libopenal.so.1 ./libopenal.so.1.19.1
gzip lib.zip
echo "if you use vscode, please download lib.zip"
