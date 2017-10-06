use <../primitives/roundedCube.scad>;

// Example:
difference() {
  cube([ 60, 50, 20 ]);
  roundedWindow(
    x = 60,
    y = 50,
    z = 20,
    r = 5,
    padding = 10,
    $fn = 30
  );
}

module roundedWindow(
  x,
  y,
  z,
  r,
  padding = 0
) {
  _x = x - padding * 2;
  _y = y - padding * 2;

  if (_x - r * 2 <= 0) {
    echo("<b style='color: red'>WARNING</b>: roundedWindow() is too small along its x-axis");
  }
  if (_y - r * 2 <= 0) {
    echo("<b style='color: red'>WARNING</b>: roundedWindow() is too small along its y-axis");
  }

  translate([ _x / -2 + padding, _y / -2 + padding, 0 ])
  difference() {
    translate([ _x / 2 - r, _y / 2 - r, 0 ])
    cube([ _x + 2 * r, _y + 2 * r, z ]);
    minkowski() {
      difference() {
        cube([ _x * 2, _y * 2, z - r ]);
        translate([ _x / 2 - r, _y / 2 - r, 0 ])
        cube([ _x + r * 2, _y + r * 2, z + r ]);
      }
      sphere(r = r);
    }
  }
}
