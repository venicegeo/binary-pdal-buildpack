BASE_IMAGE="cloudfoundry/cflinuxfs2"

copy_changed_libs() {
  docker diff $(docker ps -lq) | grep '\.so' | tr -d ^[^AC] | while read -r line; do
      docker cp $(docker ps -lq):$line $(pwd)/pdal-vendor/lib/.
  done
}

run_script() {
  docker run -v $(pwd):/scripts $BASE_IMAGE /scripts/$1
}

# create output directories
mkdir -p $(pwd)/pdal-vendor
mkdir -p $(pwd)/pdal-vendor/bin
mkdir -p $(pwd)/pdal-vendor/include
mkdir -p $(pwd)/pdal-vendor/lib
mkdir -p $(pwd)/pdal-vendor/share

# build and copy gdal files
run_script gdal-script.sh
docker cp $(docker ps -lq):/usr/local/include $(pwd)/pdal-vendor/include
copy_changed_libs
docker diff $(docker ps -lq) | grep '/usr/local/bin/*gdal*' | tr -d ^[^AC] | while read -r line; do
    docker cp $(docker ps -lq):$line $(pwd)/pdal-vendor/bin/.
done
docker cp $(docker ps -lq):/usr/local/share/gdal $(pwd)/pdal-vendor/share/.

# build and copy hexer files
run_script hexer-script.sh
docker cp $(docker ps -lq):/usr/include/hexer $(pwd)/pdal-vendor/include/hexer
copy_changed_libs

# build and copy laszip files
run_script laszip-script.sh
docker cp $(docker ps -lq):/usr/include/laszip $(pwd)/pdal-vendor/include/laszip
copy_changed_libs

# build and copy nitro files
run_script nitro-script.sh
docker cp $(docker ps -lq):/usr/include/nitro $(pwd)/pdal-vendor/include/nitro
copy_changed_libs

# build and copy libgeotiff files
run_script libgeotiff-script.sh
docker cp $(docker ps -lq):/usr/local/include $(pwd)/pdal-vendor/include
copy_changed_libs

# build and copy laz-perf files
run_script laz-perf-script.sh
docker cp $(docker ps -lq):/usr/include/laz-perf $(pwd)/pdal-vendor/include/laz-perf
copy_changed_libs

# build and copy points2grid files
docker run -v $(pwd):/scripts -v $(pwd)/pdal-vendor:/usr/local $BASE_IMAGE /scripts/points2grid-script.sh
docker cp $(docker ps -lq):/usr/include/points2grid $(pwd)/pdal-vendor/include/points2grid
copy_changed_libs

# download, install, and copy eigen headers to vendor directory
run_script eigen-script.sh
docker cp $(docker ps -lq):/usr/include/Eigen $(pwd)/pdal-vendor/include/Eigen
docker cp $(docker ps -lq):/usr/include/unsupported $(pwd)/pdal-vendor/include/unsupported

# build and copy pcl files
docker run -v $(pwd):/scripts -v $(pwd)/pdal-vendor:/usr/local $BASE_IMAGE /scripts/pcl-script.sh
docker cp $(docker ps -lq):/usr/include/pcl-1.7 $(pwd)/pdal-vendor/include/pcl-1.7
copy_changed_libs

# download, install, and copy proj data files to vendor directory
run_script vdatum-script.sh
docker cp $(docker ps -lq):/usr/share/proj $(pwd)/pdal-vendor/share/.

# build pdal in cflinuxfs2
run_script pdal-script.sh
copy_changed_libs
docker diff $(docker ps -lq) | grep '/usr/bin/*pdal*' | tr -d ^[^AC] | while read -r line; do
    docker cp $(docker ps -lq):$line $(pwd)/pdal-vendor/bin/.
done

# build prc in cflinuxfs2
docker run -v $(pwd):/scripts cloudfoundrya/cflinuxfs2 /scripts/prc-script.sh

tar -cvzf pdal.tar.gz pdal-vendor
