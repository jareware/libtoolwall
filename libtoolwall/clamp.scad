include <../config.scad>;

use <../primitives/roundedCube.scad>;
use <../utilities/screwHole.scad>;

// Example:
clamp(
  width = 20,
  height = 25,
  depth = 5,
  padding = 3,
  bottomExtraSturdiness = 4,
  topExtraSturdiness = 1,
  middleExtraPadding = -2,
  extraDistanceFromWall = 3,
  $fn = 50
);

module clamp(
  width,
  height,
  depth,
  padding,
  bottomExtraSturdiness = 0,
  topExtraSturdiness = 0,
  middleExtraPadding = 0,
  extraDistanceFromWall = 0
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
    roundedCube(width, wallThickBot, WALL_ATTACHMENT_THICKNESS + extraDistanceFromWall + depth + wallThickTop, r = GLOBAL_ROUNDING, flatBottom = true, flatBack = true);

    // Clamp upward extrusion:
    translate([ 0, 0, WALL_ATTACHMENT_THICKNESS + extraDistanceFromWall + depth ])
    roundedCube(width, wallThickBot + height, wallThickTop, r = GLOBAL_ROUNDING, flatBottom = true);

    // Object outward extrusion (if selected):
    if (extraDistanceFromWall > 0) {
      translate([ padding, 0, 0 ])
      roundedCube(width - padding * 2, wallThickBot + height, WALL_ATTACHMENT_THICKNESS + extraDistanceFromWall, r = GLOBAL_ROUNDING);
    }

    // Show space for object:
    translate([ 0, wallThickBot, WALL_ATTACHMENT_THICKNESS + extraDistanceFromWall ])
    %cube([ width, height, depth ]);

  }

}
