include <../config.scad>;

use <../primitives/roundedCube.scad>;
use <../utilities/screwHole.scad>;
use <../utilities/roundedWindow.scad>;

// Example:
basket(
  width = 30,
  height = 30,
  depth = 5,
  $fn = 20
);

module basket(
  width,
  height,
  depth,
  windowPadding = 7.5,
  groovePadding = 2.5
) {

  outerWidth = width + WALL_THICKNESS * 2;
  outerHeight = height + WALL_THICKNESS * 1;
  outerDepth = depth + WALL_ATTACHMENT_THICKNESS + WALL_THICKNESS;

  difference() {

    // Main body:
    roundedCube(outerWidth, outerHeight, outerDepth, r = GLOBAL_ROUNDING, flatBottom = true);

    // Remove space for contained object:
    translate([ WALL_THICKNESS, WALL_THICKNESS, WALL_ATTACHMENT_THICKNESS ])
    cube([ width, height, depth ]);

    // Open a window:
    translate([ 0, 0, WALL_ATTACHMENT_THICKNESS ])
    roundedWindow(outerWidth, outerHeight, depth + WALL_THICKNESS, r = GLOBAL_ROUNDING, padding = windowPadding);

    // Add screw hole:
    translate([ outerWidth / 2, outerHeight / 2, 0 ])
    screwHole();

    // Add "grooves" to bottom to remove unnecessary material:
    grooveWidth = width / 2 - groovePadding * 2 - SCREW_HEAD_DIAMETER / 2;
    translate([ WALL_THICKNESS + groovePadding, WALL_THICKNESS, WALL_THICKNESS ])
    cube([ grooveWidth, height, WALL_ATTACHMENT_THICKNESS - WALL_THICKNESS ]);
    translate([ WALL_THICKNESS + width - groovePadding - grooveWidth, WALL_THICKNESS, WALL_THICKNESS ])
    cube([ grooveWidth, height, WALL_ATTACHMENT_THICKNESS - WALL_THICKNESS ]);

  }

}
