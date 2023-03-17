ndk_root=$(pwd)/android-ndk-r14b
prefix_root=$(pwd)/android
rm -rf $prefix_root
version=1.19.0
prefix_root=$prefix_root/$version


build(){
    for build_type in Debug #Release MinSizeRel
    do
        echo begin build [$abi / $build_type] ...
        rm -rf ./build
        mkdir ./build
        cd ./build

        install_prefix=$prefix_root/$abi/$build_type
        sysroot=$ndk_root/platforms/android-21/arch-$arch
        if ! [ -d "$sysroot" ]; then
            echo "not exist: $sysroot"
            exit 
        fi

        toolchains=$ndk_root/toolchains/$toolchains_prefix-4.9/prebuilt/linux-x86_64/bin
        if ! [ -d "$toolchains" ]; then
            echo "not exist: $toolchains"
            exit 
        fi
        cmake .. \
            -DCMAKE_SYSTEM_NAME=Android \
            -DANDROID_STL=c++_shared \
            -DANDROID_LD=lld \
            -DANDROID_ABI=$abi \
            -DCMAKE_C_COMPILER=$toolchains/$toolchains_prefix-gcc \
            -DCMAKE_CXX_COMPILER=$toolchains/$toolchains_prefix-g++ \
            -DCMAKE_RC_COMPILER=$toolchains/$toolchains_prefix-windres \
            -DCMAKE_INSTALL_PREFIX=$install_prefix \
            -DCMAKE_SYSROOT=$sysroot $sysroot/usr/lib \
            -DANDROID_NDK=$ndk_root \
            -DCMAKE_BUILD_TYPE=$build_type \
            -DANDROID_PLATFORM=android-21 \
            -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
            -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
            -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
            
        make
        if [ $? -ne 0 ]; then
            echo make failed [$abi / $build_type] ...
            exit
        fi

        make install
        if [ $? -ne 0 ]; then
            echo make install failed [$abi / $build_type] ...
            exit
        fi

        cd ..
    done
    echo $abi finished!
}

# toolchains_prefix=arm-linux-androideabi
# arch=arm
# abi=armeabi-v7a
# build 

toolchains_prefix=aarch64-linux-android
arch=arm64
abi=arm64-v8a
build