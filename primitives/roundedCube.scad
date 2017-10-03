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
  r = 0,
  flatTop = false,
  flatBottom = false,
  flatLeft = false,
  flatRight = false,
  flatFront = false,
  flatBack = false
) {
  difference() {
    // Main rounded cube:
    translate([
      flatLeft ? 0 : r,
      flatFront ? 0 : r,
      flatBottom ? 0 : r
    ]) {
      minkowski() {
        cube([
          x - r * (flatLeft && flatRight ? 0 : (flatLeft || flatRight ? 1 : 2)),
          y - r * (flatFront && flatBack ? 0 : (flatFront || flatBack ? 1 : 2)),
          z - r * (flatTop && flatBottom ? 0 : (flatTop || flatBottom ? 1 : 2))
        ]);
        sphere(r = r);
      }
    }
    // Optional cutouts:
    // (let's not generate unnecessary geometry)
    if (flatTop) {
      translate([ x / -2, y / -2, z ])
      cube([ x * 2, y * 2, z ]);
    }
    if (flatBottom) {
      translate([ x / -2, y / -2, -z ])
      cube([ x * 2, y * 2, z ]);
    }
    if (flatLeft) {
      translate([ -x, y / -2, z / -2 ])
      cube([ x, y * 2, z * 2 ]);
    }
    if (flatRight) {
      translate([ x, y / -2, z / -2 ])
      cube([ x, y * 2, z * 2 ]);
    }
    if (flatFront) {
      translate([ x / -2, -y, z / -2 ])
      cube([ x * 2, y, z * 2 ]);
    }
    if (flatBack) {
      translate([ x / -2, y, z / -2 ])
      cube([ x * 2, y, z * 2 ]);
    }
  }
}
