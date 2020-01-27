cite about-plugin
about-plugin 'Michals utilities'

function dimmer {
	about 'Dimmer screen'
	group 'michal'

	local SYNTAX="\\n \\t SYNTAX: dimmer level \\n \\t Where 'level' ranges from 0 to 100.\\n";

	local LEVEL=$1
	if [ $LEVEL -gt 100 ]; then
		echo -e $SYNTAX;
		exit 1;
	fi

	if [ $LEVEL -lt 0 ]; then
		echo -e $SYNTAX;
		exit 1;
	fi

	local brightness_level="$(( $LEVEL / 100 )).$(( $LEVEL % 100 ))"
	local screename=$(xrandr | grep " connected" | cut -f1 -d" ")
	xrandr --output $screename --brightness $brightness_level;
	echo -e "[info]: Screen Brightness set to" $LEVEL"%"
}
