include <../config.scad>;

use <../primitives/distributeChildren.scad>;
use <../utilities/screwHole.scad>;

// Example:
difference() {
  translate([ 5, 10, 0 ])
  cube([ 40, 30, 10 ]);
  #autoScrewHoles(
    areaWidth = 40,
    areaHeight = 30,
    translateX = 5,
    translateY = 10,
    padding = 3
  );
}

module autoScrewHoles(
  areaWidth,
  areaHeight,
  translateX = 0,
  translateY = 0,
  padding = 0
) {
  // Distribute along X axis:
  if (areaWidth > areaHeight) {
    translate([ translateX, translateY + areaHeight / 2, 0 ])
    // If we can with 2 holes:
    if (areaWidth > SCREW_ACCESS_DIAMETER * 2) {
      distributeChildren(
        alongX = areaWidth,
        paddingX = SCREW_ACCESS_DIAMETER / 2 + padding
      ) {
        screwHole();
        screwHole();
      }
    // If we can only fit 1:
    } else {
      translate([ areaWidth / 2, 0, 0 ])
      screwHole();
    }
  // Distribute along Y axis:
  } else {
    translate([ translateX + areaWidth / 2, translateY, 0 ])
    // If we can with 2 holes:
    if (areaHeight > SCREW_ACCESS_DIAMETER * 2) {
      rotate([ 0, 0, 90 ])
      distributeChildren(
        alongX = areaHeight,
        paddingX = SCREW_ACCESS_DIAMETER / 2 + padding
      ) {
        screwHole();
        screwHole();
      }
    // If we can only fit 1:
    } else {
      translate([ 0, areaHeight / 2, 0 ])
      screwHole();
    }
  }
}
