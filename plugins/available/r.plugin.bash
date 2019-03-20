cite about-plugin
about-plugin 'R specific functions'

function update-packages {
	about 'update packages in .libPaths()[1] library'
	group 'r'

	# Get number of cores
	local NCORES=$(grep -c ^processor /proc/cpuinfo)
	local USE_CORES=$(expr $NCORES - 1)
	MAKE='make -j $USE_CORES' Rscript -e 'update.packages(ask=FALSE, lib=.libPaths()[1])'
}


function autotest-package {
	about 'launch package autocheck from testthat'
	group 'r'

	Rscript -e 'testthat::auto_test_package()'
}

