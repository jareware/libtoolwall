include <../config.scad>;

use <../primitives/roundedCube.scad>;
use <../utilities/screwHole.scad>;

// Example:
basket(
  width = 30,
  height = 40,
  depth = 5,
  coverHeight = 30,
  $fn = 20
);

module basket(
  width,
  height,
  depth,
  coverHeight,
  rounding = 2
) {

  outerWidth = width + WALL_THICKNESS * 2;
  outerHeight = height + WALL_THICKNESS * 1;
  outerDepth = depth + WALL_ATTACHMENT_THICKNESS + WALL_THICKNESS;

  difference() {

    union() {
      // Wall attachment:
      roundedCube(outerWidth, outerHeight, WALL_ATTACHMENT_THICKNESS, r = rounding, flatBottom = true);
      // Main container:
      roundedCube(outerWidth, coverHeight, outerDepth, r = rounding, flatBottom = true);
    }

    // Remove space for contained object:
    translate([ WALL_THICKNESS, WALL_THICKNESS, WALL_ATTACHMENT_THICKNESS ])
    cube([ width, height, depth ]);

    // Add screw hole:
    translate([ outerWidth / 2, coverHeight + (height - coverHeight) / 2, 0 ])
    screwHole();
  }

}
