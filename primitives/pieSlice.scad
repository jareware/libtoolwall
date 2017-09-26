use <halfCylinder.scad>;

// Example:
pieSlice(
  z = 10,
  r = 20,
  angle = 65
);

module pieSlice(
  z,
  r,
  angle,
  mergeMargin = 1 // i.e. how much to overlap joined solids
) {
  if (angle < 180) {
    // Cut a half-cylinder out of another:
    difference() {
      halfCylinder(z, r = r);
      rotate([ 0, 0, angle ])
      translate([ 0, 0, -mergeMargin ])
      halfCylinder(z + mergeMargin * 2, r = r + mergeMargin);
    }
  } else if (angle <= 360) {
    // Combine two half-cylinders with overlap:
    halfCylinder(z, r = r);
    rotate([ 0, 0, angle - 180 ])
    halfCylinder(z, r = r);
  }
}
