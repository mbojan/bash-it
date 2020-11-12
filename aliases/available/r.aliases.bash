cite 'about-alias'
about-alias 'R abbreviations'

# Aliases
alias r-oldpkg='Rscript -e "old.packages()"'
alias r-updatep='Rscript -e "update.packages(lib=.libPaths()[1], ask=FALSE, Ncpus=2)"'
alias r-autotest='Rscript -e "testthat::auto_test_package()"'
alias r-install='Rscript -e "devtools::install(build_vignettes=TRUE)"'
alias r-here='cd `Rscript -e "cat(here::here())"`'
