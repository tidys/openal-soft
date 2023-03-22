prefix_root=$(pwd)/apple
rm -rf $prefix_root
version=1.19.0
prefix_root=$prefix_root/$version


build(){
    for build_type in MinSizeRel Debug Release
    do 
        rm -rf ./build
        mkdir build
        cd build
        install_prefix=$prefix_root/$platform/$build_type
        
            # -GXcode \
            # -DALSOFT_INSTALL=OFF \
            # -DDEPLOYMENT_TARGET=9.0 \

        cmake .. \
            -DPLATFORM=$platform \
            -DCMAKE_TOOLCHAIN_FILE=./ios.toolchain.cmake \
            -DCMAKE_INSTALL_PREFIX=$install_prefix \
            -DCMAKE_BUILD_TYPE=$build_type \
            -DALSOFT_DLOPEN=OFF \
            -DALSOFT_UTILS=OFF \
            -DALSOFT_TESTS=OFF \
            -DALSOFT_EXAMPLES=OFF \
            -DLIBTYPE="STATIC"

        make OpenAL
        if [ $? -ne 0 ]; then
            echo make failed [$platform/$build_type] ...
            exit
        fi

        make install
        if [ $? -ne 0 ]; then
            echo make install failed [$platform/$build_type] ...
            exit
        fi
        echo $platform/$build_type finished!
        cd ..
    done
}

platform="OS64"
build

platform="MAC"
build