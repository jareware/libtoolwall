// Example:
roundedCube(
  x = 30,
  y = 20,
  z = 10,
  r = 3
);

module roundedCube(
  x,
  y,
  z,
  r
) {
  translate([
    r,
    r,
    r
  ]) {
    minkowski() {
      cube([
        x - r * 2,
        y - r * 2,
        z - r * 2
      ]);
      sphere(r = r);
    }
  }
}
