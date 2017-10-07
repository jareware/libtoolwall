# libtoolwall

Rendering notes:

```
OpenSCAD -o frame123.png --render --imgsize=3200,2400 --camera=32.7,-5.1,8.1,41.7,0,22.2,178.4 distributeChildren.scad
convert 'frame*.png' -set delay 1x15 animated.gif
```

Renderable text:

```
rotate([ 0, 0, 20 ])
translate([ 45, -50, 0 ])
linear_extrude(height=0.3)
text(str("t = ", round(easeInOutCubic($t) * 10) / 10));
```
