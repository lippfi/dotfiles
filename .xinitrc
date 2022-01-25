exec i3

xresources=$HOME/.Xresources
if [ -f "$xresources" ]; then
  xrdb -merge $xresources
fi
