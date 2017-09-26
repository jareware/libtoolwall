use <pieSlice.scad>;

// Example:
bentCube(
  x = 15,
  y1 = 15,
  r = 20,
  deg = 65,
  y2 = 10,
  z = 3
);

module bentCube(
  x,
  y1,
  r,
  deg,
  y2,
  z,
  mergeMargin = 1 // i.e. how much to overlap joined solids
) {
  // 1st segment (y1):
  cube([ x, y1, z ]);

  translate([ 0, y1, r ])
  rotate([ -90, 0, 0 ])
  rotate([ 0, 90, 0 ])
  {
    // 2nd segment (r & deg):
    difference() {
      pieSlice(x, r, deg);
      translate([ 0, 0, -mergeMargin ])
      cylinder(x + mergeMargin * 2, r = r - z);
    }

    // 3rd segment (y2):
    rotate([ 0, 0, deg ])
    translate([ -y2, r - z, 0 ])
    cube([ y2, z, x ]);
  }
}
