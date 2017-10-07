include <../config.scad>;

use <../primitives/roundedCube.scad>;
use <../utilities/screwHole.scad>;

// Example:
clamp(
  width = 15,
  height = 30,
  depth = 5,
  padding = 3,
  bottomExtraSturdiness = 4,
  topExtraSturdiness = 1,
  middleExtraPadding = -2
  // $fn = 50
);

module clamp(
  width,
  height,
  depth,
  padding,
  bottomExtraSturdiness = 0,
  topExtraSturdiness = 0,
  middleExtraPadding = 0
) {

  wallThickBot = WALL_THICKNESS + bottomExtraSturdiness;
  wallThickTop = WALL_THICKNESS + topExtraSturdiness;
  middlePadding = padding + middleExtraPadding;
  mountWidth = (padding + SCREW_HEAD_DIAMETER + padding > width) ? padding + SCREW_HEAD_DIAMETER + padding : width;
  mountHeight = padding + SCREW_HEAD_DIAMETER + middlePadding + height + wallThickBot; // top to bottom

  difference() {

    // Wall mount:
    roundedCube(mountWidth, mountHeight, WALL_ATTACHMENT_THICKNESS, r = GLOBAL_ROUNDING, flatBottom = true);

    // Add screw hole:
    translate([ mountWidth / 2, mountHeight - SCREW_HEAD_DIAMETER / 2 - padding, 0 ])
    screwHole();

  }

  // Clamp itself:
  translate([ mountWidth / 2 - width / 2, 0, 0 ]) {

    // Clamp outward extrusion:
    roundedCube(width, wallThickBot, WALL_ATTACHMENT_THICKNESS + depth + wallThickTop, r = GLOBAL_ROUNDING, flatBottom = true, flatBack = true);

    // Clamp upward extrusion:
    translate([ 0, 0, WALL_ATTACHMENT_THICKNESS + depth ])
    roundedCube(width, wallThickBot + height, wallThickTop, r = GLOBAL_ROUNDING, flatBottom = true);

    // Show space for object:
    translate([ 0, wallThickBot, WALL_ATTACHMENT_THICKNESS ])
    %cube([ width, height, depth ]);

  }

}
