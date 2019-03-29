cite about-plugin
about-plugin 'Windows Subsystem - Linux functions'

function launch-terminal {
	about 'launch XFCE4 terminal. X server must be running'
	group 'wsl'

	xfce4-terminal &
	disown %1
}

