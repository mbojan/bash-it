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



function dcss {
	about 'Launch DCSS in tmux with wiki in background'
	group 'michal'

        byobu  \
           new-session links http://crawl.chaosforge.org/Crawl_Wiki \; \
           new-window crawl \; 
}

function cddab {
	about 'Launch CDDA in byobu in tmux with wiki in background'
	group 'michal'

        byobu  \
           new-session links http://cddawiki.chezzo.com/cdda_wiki/index.php?title=Main_Page \; \
           new-window links http://cdda.chezzo.com/ \; \
	   new-window links https://cddawiki.chezzo.com/cdda_wiki/index.php?title=A_Skill_Training_Encyclopedia \; \
           new-window cdda \; 
}
