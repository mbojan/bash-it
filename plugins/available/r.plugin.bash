cite about-plugin
about-plugin 'R specific functions'

function rpkg-u {
	about 'update R packages'
	group 'r'

	usage() {
		echo ""
		echo "Update R packages in specified library"
		echo ""
		echo "Usage: rpkg-u [-l <string>] [-p <integer>]" 1>&2
		echo ""
		echo "-l  Library path. Defaults to .libPaths()[1]"
		echo "-p  Number of cores. Defaults to 1"
		echo ""
	}

	while getopts ":l:p:" o; do
		case "${o}" in
			l)
				local l=${OPTARG}
				;;
			p)
				local p=${OPTARG}
				;;
			*)
				usage
				;;
		esac
	done
	shift $((OPTIND-1))

	if [ -z "${l}" ]; then
		local l=1
	fi

	if [ -z "${p}" ]; then
		local p=1
	fi

	echo "l = ${l}"
	echo "p = ${p}"
	
	echo "MAKE='make -j${p}' Rscript -e 'update.packages(lib=.libPaths()[${l}], ask=FALSE, checkBuilt=TRUE)'"
}


function rpkg-github {
	about 'install R package from GitHub'
	param '1: user/repo string to GH repository with the package'
	group 'r'

	Rscript -e "remotes::install_github(\"$1\", build_vignettes=TRUE, force=TRUE)"
}


function rpkg-update {
	about 'update packages in .libPaths()[1] library with parallel compilation'
	group 'r'

	# Get number of cores
	local NCORES=$(grep -c ^processor /proc/cpuinfo)
	local USE_CORES=$(expr $NCORES - 1)

	echo Updating R packages in $(Rscript -e 'cat(.libPaths()[1])') using $USE_CORES cores
	MAKE='make -j $USE_CORES' Rscript -e 'update.packages(ask=FALSE, lib=.libPaths()[1], checkBuilt=TRUE)'
}

function rpkg-update1 {
	about 'update packages in .libPaths()[1] library using one core'
	group 'r'

	Rscript -e 'update.packages(ask=FALSE, lib=.libPaths()[1])'
}

function rpkg-update2 {
	about 'update packages in .libPaths()[1] library using two cores'
	group 'r'

	MAKE='make -j2' Rscript -e 'update.packages(ask=FALSE, lib=.libPaths()[1])'
}

function rpkg-updatep {
	about 'update packages in .libPaths()[1] library in parallel'
	group 'r'

	# Get number of cores
	local NCORES=$(grep -c ^processor /proc/cpuinfo)
	local USE_CORES=$(expr $NCORES - 1)

	Rscript -e "update.packages(ask=FALSE, lib=.libPaths()[1], Ncpus=$USE_CORES, checkBuilt=TRUE)"
}

function rpkg-autotest {
	about 'launch package autocheck from testthat'
	group 'r'

	Rscript -e 'testthat::auto_test_package()'
}


function rstudio-start {
	about 'start rstudio server'
	group 'r'

	echo Launch RStudio Server
	service rstudio-server start
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

function rpkg-old {
	about 'check for old packages'
	group 'r'

	Rscript -e 'old.packages()'
}


function r-render {
	about 'run rmarkdown::render() via Rscript'
	param '1: name of Rmd file to render'
	group 'r'

	Rscript -e "rmarkdown::render(\"$1\")"
}

