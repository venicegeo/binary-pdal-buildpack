docker run -v $(pwd):/scripts cloudfoundry/cflinuxfs2 /scripts/script.sh

mkdir -p $(pwd)/vendor

mkdir -p $(pwd)/vendor/lib
docker diff $(docker ps -lq) | grep '\.so' | tr -d ^[^AC] | while read -r line; do
    docker cp $(docker ps -lq):$line $(pwd)/vendor/lib/.
done

mkdir -p $(pwd)/vendor/bin
docker diff $(docker ps -lq) | grep '/usr/bin/*gdal*' | tr -d ^[^AC] | while read -r line; do
    docker cp $(docker ps -lq):$line $(pwd)/vendor/bin/.
done

mkdir -p $(pwd)/vendor/share
docker cp $(docker ps -lq):/usr/share/gdal $(pwd)/vendor/share/.

tar -cvzf gdal-bin.tar.gz vendor
