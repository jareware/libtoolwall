// Example:
roundedCube(
  x = 30,
  y = 20,
  z = 10,
  r = 3,
  flatBottom = true
);

module roundedCube(
  x,
  y,
  z,
  r,
  flatBottom = false
) {
  difference() {
    // Main rounded cube:
    translate([
      r,
      r,
      flatBottom ? 0 : r
    ]) {
      minkowski() {
        cube([
          x - r * 2,
          y - r * 2,
          z - r * (flatBottom ? 1 : 2)
        ]);
        sphere(r = r);
      }
    }
    // Optional cutouts:
    if (flatBottom) {
      translate([ 0, 0, -z ])
      cube([ x, y, z ]);
    }
  }
}
