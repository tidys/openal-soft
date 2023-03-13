ndk_dir=$(pwd)/android-ndk-r14b
rm -rf ./build
mkdir ./build
cd ./build
compiler=$ndk_dir/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin
sysroot=$ndk_dir/sysroot
platform=$ndk_dir/platforms/android-9/arch-arm/
export PATH=$PATH:$compiler # :$sysroot:$platform
echo $PATH
cmake ..    -DCMAKE_TOOLCHAIN_FILE=../XCompile-Android.txt \
            -DHOST=arm-linux-androideabi \
        #    -DCMAKE_C_FLAGS="-std=c99 -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -ffunction-sections -funwind-tables -fstack-protector-strong -fPIC -Wall -Wa,--noexecstack -Wformat -Werror=format-security -no-canonical-prefixes -DANDROID -DPLATFORM_ANDROID -D__ANDROID_API__=16"
make
 
