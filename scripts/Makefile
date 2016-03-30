# The one and only place to change the base image. The current GEOINT SERVICES
# stack uses Cloud Foundry's cflinuxfs2.
BASE_IMAGE=cloudfoundry/cflinuxfs2

# The one and only place to change the output directory for compiled binaries,
# headers, etc. that we will need to archive and deploy with.
VENDORDIR=$(shell pwd)/vendor/pdal

# A slight convenience...
BINDIR=$(VENDORDIR)/bin
INCDIR=$(VENDORDIR)/include
LIBDIR=$(VENDORDIR)/lib
SHAREDIR=$(VENDORDIR)/share

# Perform a Docker diff on the last container, finding only shared libraries
# that were Added or Changed, and copying them to the output directory.
define copy_changed_libs
docker diff $$(docker ps -lq) | grep '\.so' | sed 's/^[AC]//' | while read -r line; do \
	docker cp $$(docker ps -lq):$$line $(LIBDIR)/.; \
done;
endef

# Run the requested installation script within a Docker container.
run_script = docker run -v $(shell pwd)/scripts:/scripts -v $(VENDORDIR):/usr/local $(BASE_IMAGE) /scripts/$(1)

rm_last_image = docker rm -v $$(docker ps -lq)

help:
	@echo ""
	@echo "make all"
	@echo "make archive"
	@echo "make clean"
	@echo "make eigen"
	@echo "make gdal"
	@echo "make help"
	@echo "make hexer"
	@echo "make init"
	@echo "make laszip"
	@echo "make laz-perf"
	@echo "make libgeotiff"
	@echo "make nitro"
	@echo "make pcl"
	@echo "make pdal"
	@echo "make points2grid"
	@echo "make prc"
	@echo "make vdatum"
	@echo ""

.PHONY: gdal hexer laszip nitro libgeotiff laz-perf points2grid eigen pcl pdal prc vdatum archive

all: init eigen hexer laszip laz-perf libgeotiff nitro pcl gdal vdatum points2grid pdal prc archive

# All of our targets assume an output directory structure is in place. It is
# created here.
init:
	mkdir -p $(VENDORDIR)
	mkdir -p $(BINDIR)
	mkdir -p $(INCDIR)
	mkdir -p $(LIBDIR)
	mkdir -p $(SHAREDIR)

# Execute our GDAL installation script. Copy all headers, libs, binaries, and
# data.
gdal: init
	$(call run_script,gdal.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# build and copy hexer files
hexer: init
	rm -rf $(INCDIR)/hexer
	$(call run_script,hexer.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# build and copy laszip files
laszip: init
	rm -rf $(INCDIR)/laszip
	$(call run_script,laszip.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# build and copy nitro files
nitro: init
	rm -rf $(INCDIR)/nitro
	$(call run_script,nitro.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# build and copy libgeotiff files
libgeotiff: init
	$(call run_script,libgeotiff.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# build and copy laz-perf files
laz-perf: init
	rm -rf $(INCDIR)/laz-perf
	$(call run_script,laz-perf.sh)
	$(call rm_last_image)

# build and copy points2grid files
points2grid: init
	rm -rf $(INCDIR)/points2grid
	$(call run_script,points2grid.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# download, install, and copy eigen headers to vendor directory
eigen: init
	rm -rf $(INCDIR)/Eigen $(INCDIR)/unsupported
	$(call run_script,eigen.sh)
	$(call rm_last_image)

# build and copy pcl files
pcl: init
	rm -rf $(INCDIR)/pcl-1.7
	$(call run_script,pcl.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# download, install, and copy proj data files to vendor directory
vdatum: init
	rm -rf $(SHAREDIR)/proj
	$(call run_script,vdatum.sh)
	$(call rm_last_image)

# build pdal in cflinuxfs2
pdal: init
	rm -rf $(INCDIR)/pdal
	$(call run_script,pdal.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# build prc in cflinuxfs2
prc: init
	$(call run_script,prc.sh)
	$(call copy_changed_libs)
	$(call rm_last_image)

# Wipe the output directory away completely!
clean:
	rm -rf $(VENDORDIR)

# Archive the output directory as pdal.tar.gz.
archive: init
	tar -cvzf $(shell pwd)/vendor/pdal.tar.gz $(VENDORDIR)/bin/pdal $(VENDORDIR)/lib
