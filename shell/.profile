# NOTE: it seems that this coords are based on the current screen specs

xrandr --newmode "1920x1080R"  138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync
xrandr --addmode VGA-1 "1920x1080R"

xrandr --newmode "1600x900R"   97.50  1600 1648 1680 1760  900 903 908 926 +hsync -vsync
xrandr --addmode VGA-1 "1600x900R"

xrandr --newmode "1440x900R"   88.75  1440 1488 1520 1600  900 903 909 926 +hsync -vsync
xrandr --addmode VGA-1 "1440x900R"

xrandr --newmode "1368x768R"   72.25  1368 1416 1448 1528  768 771 781 790 +hsync -vsync
xrandr --addmode VGA-1 "1368x768R"

xrandr --output VGA-1 --mode "1920x1080R"
