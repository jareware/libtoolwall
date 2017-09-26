// Example:
halfCylinder(
  z = 20,
  r = 10
);

module halfCylinder(
  z,
  r,
  mergeMargin = 1 // i.e. how much to overlap joined solids
) {
  difference() {
    // Cylinder itself:
    cylinder(z, r = r);
    // Cutoff part:
    translate([ 0, -r, -mergeMargin ])
    cube([ r, r * 2, z + mergeMargin * 2 ]);
  }
}
