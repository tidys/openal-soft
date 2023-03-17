ndk_root=$(pwd)/android-ndk-r20b
prefix_root=$(pwd)/android
rm -rf $prefix_root
version=1.22.0
prefix_root+=$version

for abi in arm64-v8a # armeabi-v7a
do 
    for build_type in Debug # Release MinSizeRel
    do
        echo begin build [$abi / $build_type] ...
        prefix=$prefix_root/$abi/$build_type
        rm -rf ./build
        mkdir ./build
        cd ./build
        cmake .. \
            -DCMAKE_BUILD_TYPE=$build_type \
            -DANDROID_STL=c++_shared \
            -DANDROID_ABI=$abi \
            -DCMAKE_INSTALL_PREFIX=$prefix \
            -DANDROID_PLATFORM=android-21 \
            -DCMAKE_TOOLCHAIN_FILE=${ndk_root}/build/cmake/android.toolchain.cmake



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
        echo build success [$abi / $build_type] ...
    done
done