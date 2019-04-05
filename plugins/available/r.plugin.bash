cite about-plugin
about-plugin 'R specific functions'


function rpkg-update {
	about 'update packages in .libPaths()[1] library'
	group 'r'

	# Get number of cores
	local NCORES=$(grep -c ^processor /proc/cpuinfo)
	local USE_CORES=$(expr $NCORES - 1)

	echo Updating R packages in $(Rscript -e 'cat(.libPaths()[1])') using $USE_CORES cores
	MAKE='make -j $USE_CORES' Rscript -e 'update.packages(ask=FALSE, lib=.libPaths()[1])'
}


function rpkg-autotest {
	about 'launch package autocheck from testthat'
	group 'r'

	Rscript -e 'testthat::auto_test_package()'
}


function rstudio-start {
	about 'start rstudio server'
	group 'r'

	echo Launch RStudio Server with sudo
	sudo service rstudio-server start
}


function rpkg-install {
	about 'install R package parallelled'
	param '1: name of the package to install'
	group 'r'

	# Get number of cores
	local NCORES=$(grep -c ^processor /proc/cpuinfo)
	local USE_CORES=$(expr $NCORES - 1)

	echo Installing package $1 using $USE_CORES cores
	MAKE="make -j$USE_CORES" Rscript -e "install.packages(\"$1\")"
}

