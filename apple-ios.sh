prefix_root=$(pwd)/apple
rm -rf $prefix_root
version=1.19.0
prefix_root=$prefix_root/$version

for build_type in MinSizeRel; do #Debug Release
    rm -rf ./build
    mkdir build
    cd build
    install_prefix=$prefix_root/$build_type

    cmake .. \
        -DCMAKE_INSTALL_PREFIX=$install_prefix \
        -DCMAKE_BUILD_TYPE=$build_type \
        -DPLATFORM=OS \
        -DLIBTYPE="STATIC"

    make
    if [ $? -ne 0 ]; then
        echo make failed [$build_type] ...
        exit
    fi

    make install
    if [ $? -ne 0 ]; then
        echo make install failed [$build_type] ...
        exit
    fi
    echo $build_type finished!
    cd ..
done
